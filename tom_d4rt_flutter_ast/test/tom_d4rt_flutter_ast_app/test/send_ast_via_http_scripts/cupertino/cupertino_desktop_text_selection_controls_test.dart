// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Hand-authored deep demo of CupertinoDesktopTextSelectionControls
// from package:flutter/cupertino.dart. The script renders multiple panels that
// each instantiate CupertinoTextField widgets configured to use the desktop
// selection controls singleton (cupertinoDesktopTextSelectionControls), so the
// class is materially in use throughout the demo, not merely described.
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('CupertinoDesktopTextSelectionControls demo starting');

  // ========================================================================
  // DATA-COLLECTION PASS A: Geometry probes for the desktop controls singleton.
  // We exercise getHandleSize and getHandleAnchor at multiple text scales so
  // the rendered cards can show the *exact* numbers Flutter would use when
  // the selection toolbar materialises in a CupertinoTextField on desktop.
  // ========================================================================
  final desktopControls = cupertinoDesktopTextSelectionControls;
  final touchControls = cupertinoTextSelectionControls;

  final probeScales = <double>[10.0, 12.0, 14.0, 16.0, 20.0, 28.0];
  final geometryRows = <Map<String, dynamic>>[];
  for (final scale in probeScales) {
    final desktopHandle = desktopControls.getHandleSize(scale);
    final touchHandle = touchControls.getHandleSize(scale);
    final desktopLeftAnchor = desktopControls.getHandleAnchor(
      TextSelectionHandleType.left,
      scale,
    );
    final desktopRightAnchor = desktopControls.getHandleAnchor(
      TextSelectionHandleType.right,
      scale,
    );
    final desktopCollapsedAnchor = desktopControls.getHandleAnchor(
      TextSelectionHandleType.collapsed,
      scale,
    );
    final touchLeftAnchor = touchControls.getHandleAnchor(
      TextSelectionHandleType.left,
      scale,
    );
    geometryRows.add(<String, dynamic>{
      'scale': scale,
      'desktopWidth': desktopHandle.width,
      'desktopHeight': desktopHandle.height,
      'touchWidth': touchHandle.width,
      'touchHeight': touchHandle.height,
      'desktopLeftAnchor': desktopLeftAnchor,
      'desktopRightAnchor': desktopRightAnchor,
      'desktopCollapsedAnchor': desktopCollapsedAnchor,
      'touchLeftAnchor': touchLeftAnchor,
    });
  }
  for (final row in geometryRows) {
    print(
      '  scale=${row['scale']} desktop=${row['desktopWidth']}x${row['desktopHeight']} '
      'touch=${row['touchWidth']}x${row['touchHeight']}',
    );
  }

  // ========================================================================
  // DATA-COLLECTION PASS B: Identity inspection. Confirms the singleton is a
  // CupertinoDesktopTextSelectionControls and that it differs from the touch
  // singleton by runtime type, even though both implement TextSelectionControls.
  // ========================================================================
  // Use Object refs so we can do meaningful runtime is-checks without the
  // analyzer flagging them as redundant. The whole point is to demonstrate
  // type relationships at runtime.
  final Object desktopRef = desktopControls;
  final Object touchRef = touchControls;
  final Object freshDesktop = CupertinoDesktopTextSelectionControls();
  final identityRows = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'cupertinoDesktopTextSelectionControls',
      'runtimeType': desktopRef.runtimeType.toString(),
      'isTextSelectionControls': desktopRef is TextSelectionControls,
      'isDesktopControls': desktopRef is CupertinoDesktopTextSelectionControls,
    },
    <String, dynamic>{
      'label': 'cupertinoTextSelectionControls',
      'runtimeType': touchRef.runtimeType.toString(),
      'isTextSelectionControls': touchRef is TextSelectionControls,
      'isDesktopControls': touchRef is CupertinoDesktopTextSelectionControls,
    },
    <String, dynamic>{
      'label': 'fresh CupertinoDesktopTextSelectionControls()',
      'runtimeType': freshDesktop.runtimeType.toString(),
      'isTextSelectionControls': freshDesktop is TextSelectionControls,
      'isDesktopControls':
          freshDesktop is CupertinoDesktopTextSelectionControls,
    },
  ];
  for (final row in identityRows) {
    print('  ${row['label']} -> ${row['runtimeType']}');
  }

  // ========================================================================
  // DATA-COLLECTION PASS C: Capability matrix per selection state. The desktop
  // toolbar shows different buttons depending on what is selected and whether
  // the field is editable. We document the *intent* of those rules per row so
  // the rendered card explains exactly which buttons appear when.
  // ========================================================================
  final capabilityRows = <Map<String, dynamic>>[
    <String, dynamic>{
      'state': 'No selection (collapsed caret)',
      'copy': false,
      'cut': false,
      'paste': true,
      'selectAll': true,
      'note':
          'Desktop menu offers Paste and Select All when there is nothing to copy or cut.',
    },
    <String, dynamic>{
      'state': 'Partial selection in editable field',
      'copy': true,
      'cut': true,
      'paste': true,
      'selectAll': true,
      'note':
          'Full menu strip: Cut | Copy | Paste | Select All, rendered as a single horizontal bar.',
    },
    <String, dynamic>{
      'state': 'All text selected in editable field',
      'copy': true,
      'cut': true,
      'paste': true,
      'selectAll': false,
      'note': 'Select All is hidden because the entire content is already selected.',
    },
    <String, dynamic>{
      'state': 'Selection in read-only field',
      'copy': true,
      'cut': false,
      'paste': false,
      'selectAll': true,
      'note': 'Cut and Paste suppressed because read-only fields cannot mutate.',
    },
    <String, dynamic>{
      'state': 'Empty read-only field',
      'copy': false,
      'cut': false,
      'paste': false,
      'selectAll': false,
      'note': 'No actions; the toolbar typically does not appear at all.',
    },
  ];
  for (final row in capabilityRows) {
    print('  state="${row['state']}" copy=${row['copy']} cut=${row['cut']}');
  }

  // ========================================================================
  // CONTROLLERS: One TextEditingController per editable scenario, each with
  // pre-populated text so the user can immediately drag-select to summon the
  // desktop toolbar. These controllers are bound to live CupertinoTextField
  // widgets further down.
  // ========================================================================
  final introController = TextEditingController(
    text: 'Drag across this sentence to see the desktop selection toolbar.',
  );
  final compareDesktopController = TextEditingController(
    text:
        'Desktop strip: Cut | Copy | Paste | Select All in one row above the caret.',
  );
  final compareTouchController = TextEditingController(
    text:
        'Touch bubble: rounded popover with handle bars dragged from the selection.',
  );
  final readOnlyController = TextEditingController(
    text:
        'Read-only fields use the same controls but disable Cut and Paste at runtime.',
  );
  final multilineController = TextEditingController(
    text:
        'Line one: select within this paragraph.\n'
        'Line two: the toolbar floats above the caret.\n'
        'Line three: try Select All to highlight everything.\n'
        'Line four: the desktop strip stays anchored on top.',
  );
  final passwordController = TextEditingController(text: 'sup3r-s3cret-passphrase');
  final searchController = TextEditingController(
    text: 'CupertinoDesktopTextSelectionControls',
  );
  final emailController = TextEditingController(text: 'engineer@tomframework.dev');
  final numericController = TextEditingController(text: '0123456789');
  final scriptController = TextEditingController(
    text:
        'final controls = cupertinoDesktopTextSelectionControls;\n'
        'CupertinoTextField(selectionControls: controls);',
  );
  final lookupController = TextEditingController(
    text: 'serendipity refactoring polymorphism asynchronous',
  );
  final shareController = TextEditingController(
    text:
        'Highlight any phrase here, then Cut, Copy, Paste, or Select All from '
        'the desktop strip menu.',
  );
  final emptyController = TextEditingController();
  final longController = TextEditingController(
    text:
        'A long-form passage exists to make sure the menu strip behaves '
        'sensibly even when the surrounding text wraps onto multiple visual '
        'lines inside a single CupertinoTextField. Selecting across line '
        'wraps still produces a single horizontal toolbar above the caret.',
  );

  // ========================================================================
  // BUILD THE WIDGET TREE.
  // ========================================================================
  print('CupertinoDesktopTextSelectionControls demo widget tree assembling');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Desktop Text Selection Controls'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // ============================================================
              // HERO HEADER
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFF1B263B), Color(0xFF415A77)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'CupertinoDesktopTextSelectionControls',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE0E1DD),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'The macOS / Windows / Linux text-selection toolbar for '
                      'CupertinoTextField, exposed as the singleton '
                      'cupertinoDesktopTextSelectionControls.',
                      style: TextStyle(fontSize: 14.0, color: Color(0xFFE0E1DD)),
                    ),
                    const SizedBox(height: 14.0),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: <Widget>[
                        _heroChip('menu strip'),
                        _heroChip('no drag handles'),
                        _heroChip('Cut / Copy / Paste / Select All'),
                        _heroChip('singleton ready to plug in'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ============================================================
              // CONCEPT PANEL (prose)
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: const Color(0xFF93C5FD), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'What is this class?',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3A8A),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'CupertinoDesktopTextSelectionControls is the desktop-flavoured '
                      'TextSelectionControls implementation used by CupertinoTextField. '
                      'Where the touch variant draws bubble handles and a popover, the '
                      'desktop variant draws no handles and a single horizontal strip of '
                      'menu items (Cut, Copy, Paste, Select All) anchored above the caret.',
                      style: TextStyle(fontSize: 13.5, height: 1.45),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Flutter automatically chooses this controls object on desktop '
                      'platforms (macOS, Linux, Windows) when you do not specify one. '
                      'You can also pass it explicitly via the selectionControls argument '
                      'on CupertinoTextField, which is exactly what every scenario in '
                      'this demo does so the binding is unambiguous.',
                      style: TextStyle(fontSize: 13.5, height: 1.45),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDBEAFE),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Identity:\n'
                        '  • cupertinoDesktopTextSelectionControls -> CupertinoDesktopTextSelectionControls\n'
                        '  • cupertinoTextSelectionControls        -> CupertinoTextSelectionControls (touch)\n'
                        'Both implement TextSelectionControls.',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'monospace',
                          color: Color(0xFF1E3A8A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ============================================================
              // SCENARIO 1 — INTRODUCTORY FIELD
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFFDBA74), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEA580C),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '1',
                            style: TextStyle(
                              color: Color(0xFFFFFBEB),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'A live editable field wired to the desktop toolbar',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7C2D12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: a CupertinoTextField that explicitly passes '
                      'cupertinoDesktopTextSelectionControls as selectionControls. '
                      'Drag-select a few words to summon the menu strip.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    CupertinoTextField(
                      controller: introController,
                      selectionControls: cupertinoDesktopTextSelectionControls,
                      style: const TextStyle(fontSize: 14.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFFDBA74)),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEDD5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Look for: a single horizontal bar of buttons above the '
                        'caret, with NO drag-handle bubbles below the selection.',
                        style: TextStyle(fontSize: 12.5, color: Color(0xFF7C2D12)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 2 — DESKTOP vs TOUCH SIDE-BY-SIDE
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF2F8),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFF9A8D4), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDB2777),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '2',
                            style: TextStyle(
                              color: Color(0xFFFFF1F2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Desktop strip vs Touch bubble — same content, two controls',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF831843),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: two CupertinoTextField widgets, one bound to '
                      'cupertinoDesktopTextSelectionControls (no handles, menu strip) '
                      'and one bound to cupertinoTextSelectionControls (touch handles + '
                      'iOS-style popover). Drag-select in each to compare.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    _labeledFieldRow(
                      label: 'Desktop controls',
                      labelColor: const Color(0xFF831843),
                      child: CupertinoTextField(
                        controller: compareDesktopController,
                        selectionControls: cupertinoDesktopTextSelectionControls,
                        style: const TextStyle(fontSize: 13.5),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFF9A8D4)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _labeledFieldRow(
                      label: 'Touch controls (compare)',
                      labelColor: const Color(0xFF831843),
                      child: CupertinoTextField(
                        controller: compareTouchController,
                        selectionControls: cupertinoTextSelectionControls,
                        style: const TextStyle(fontSize: 13.5),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFF9A8D4)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFCE7F3),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Compare: the desktop variant draws zero pixels of handle, '
                        'so getHandleSize returns Size.zero. The touch variant '
                        'draws bubble grips that you can drag to extend the selection.',
                        style: TextStyle(fontSize: 12.5, color: Color(0xFF831843)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 3 — GEOMETRY TABLE
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFF6EE7B7), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF059669),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              color: Color(0xFFECFDF5),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Handle geometry probe across text scales',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF065F46),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: getHandleSize and getHandleAnchor evaluated at '
                      'representative text scales. The desktop control returns a zero '
                      'handle because it does not paint any handle, while the touch '
                      'control returns a non-trivial size to host its bubble grips.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      children: const <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            'scale',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'desktop handle',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'touch handle',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            'desktop anchors (l/r/c)',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    for (final row in geometryRows)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD1FAE5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${row['scale']}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${row['desktopWidth']} x ${row['desktopHeight']}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${row['touchWidth']} x ${row['touchHeight']}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '${row['desktopLeftAnchor']} / '
                                  '${row['desktopRightAnchor']} / '
                                  '${row['desktopCollapsedAnchor']}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFA7F3D0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Look for: identical anchor outputs across scales because the '
                        'desktop control draws no scaled handle. Compare against the '
                        'touch column to see the cost of bubble grips.',
                        style: TextStyle(fontSize: 12.5, color: Color(0xFF065F46)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 4 — IDENTITY PANEL
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFFCD34D), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB45309),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '4',
                            style: TextStyle(
                              color: Color(0xFFFFFBEB),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Singleton identity & type relationships',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF78350F),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: each named selection-controls reference, the '
                      'runtime type it resolves to, and whether it satisfies the '
                      'TextSelectionControls and CupertinoDesktopTextSelectionControls '
                      'type relationships at runtime.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    for (final row in identityRows)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                row['label'] as String,
                                style: const TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF78350F),
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                'runtimeType: ${row['runtimeType']}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Text(
                                'is TextSelectionControls: ${row['isTextSelectionControls']}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Text(
                                'is CupertinoDesktopTextSelectionControls: '
                                '${row['isDesktopControls']}',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 12.0),
                    CupertinoTextField(
                      controller: scriptController,
                      selectionControls: cupertinoDesktopTextSelectionControls,
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                      ),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFFCD34D)),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'The snippet above is itself an editable field bound to the '
                      'desktop controls. Selecting the source shows the menu strip in '
                      'a code-styled context.',
                      style: TextStyle(fontSize: 12.0, color: Color(0xFF78350F)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 5 — BUTTON / CAPABILITY MATRIX
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE9FE),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFC4B5FD), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C3AED),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '5',
                            style: TextStyle(
                              color: Color(0xFFEDE9FE),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Build modes — which buttons appear when',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C1D95),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: the desktop toolbar is built from the same '
                      'capabilities as the touch toolbar (Cut, Copy, Paste, Select All), '
                      'but laid out as a single horizontal strip. The matrix below '
                      'documents which buttons appear under each selection condition.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    for (final row in capabilityRows)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDD6FE),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                row['state'] as String,
                                style: const TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4C1D95),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Wrap(
                                spacing: 6.0,
                                runSpacing: 6.0,
                                children: <Widget>[
                                  _capabilityChip(
                                    'Copy',
                                    row['copy'] as bool,
                                  ),
                                  _capabilityChip(
                                    'Cut',
                                    row['cut'] as bool,
                                  ),
                                  _capabilityChip(
                                    'Paste',
                                    row['paste'] as bool,
                                  ),
                                  _capabilityChip(
                                    'Select All',
                                    row['selectAll'] as bool,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                row['note'] as String,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  height: 1.4,
                                  color: Color(0xFF4C1D95),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 6 — READ-ONLY vs EDITABLE
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F2FE),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFF7DD3FC), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0284C7),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '6',
                            style: TextStyle(
                              color: Color(0xFFE0F2FE),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Read-only vs editable fields',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF075985),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: when readOnly is true, the desktop toolbar '
                      'omits Cut and Paste because mutation is disallowed; Copy and '
                      'Select All remain. The same selectionControls singleton is '
                      'used in both fields to prove the behaviour comes from the '
                      'controls\' build hooks, not from the field configuration.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    _labeledFieldRow(
                      label: 'Editable',
                      labelColor: const Color(0xFF075985),
                      child: CupertinoTextField(
                        controller: shareController,
                        selectionControls: cupertinoDesktopTextSelectionControls,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 13.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFF7DD3FC)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _labeledFieldRow(
                      label: 'Read-only',
                      labelColor: const Color(0xFF075985),
                      child: CupertinoTextField(
                        controller: readOnlyController,
                        selectionControls: cupertinoDesktopTextSelectionControls,
                        readOnly: true,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 13.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFF7DD3FC)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFBAE6FD),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Look for: identical menu strip styling, but a reduced button '
                        'set in the read-only field. The controls object decides which '
                        'buttons to render based on the field\'s editable state.',
                        style: TextStyle(fontSize: 12.5, color: Color(0xFF075985)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 7 — MULTILINE & WRAPPING
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF2F2),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFFCA5A5), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDC2626),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '7',
                            style: TextStyle(
                              color: Color(0xFFFEF2F2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Multiline selection across line wraps',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7F1D1D),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: a four-line CupertinoTextField bound to '
                      'cupertinoDesktopTextSelectionControls. Selecting from the middle '
                      'of one line through to the next anchors the menu strip above '
                      'the visual caret of the selection extent.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    CupertinoTextField(
                      controller: multilineController,
                      selectionControls: cupertinoDesktopTextSelectionControls,
                      maxLines: 6,
                      style: const TextStyle(fontSize: 13.0, height: 1.5),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFFCA5A5)),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    CupertinoTextField(
                      controller: longController,
                      selectionControls: cupertinoDesktopTextSelectionControls,
                      maxLines: 4,
                      style: const TextStyle(fontSize: 13.0, height: 1.5),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFFCA5A5)),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFECACA),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Look for: a single horizontal strip even when the selection '
                        'crosses several wrapped lines. The toolbar tracks the '
                        'selection extent, not the anchor.',
                        style: TextStyle(fontSize: 12.5, color: Color(0xFF7F1D1D)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 8 — SPECIALISED FIELDS (password, email, numeric, search)
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDFA),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFF5EEAD4), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0D9488),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '8',
                            style: TextStyle(
                              color: Color(0xFFF0FDFA),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Specialised fields — password, email, numeric, search',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF134E4A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: the desktop toolbar adapts to specialised '
                      'CupertinoTextField configurations. Obscured (password) fields '
                      'are notable because the framework deliberately suppresses Copy '
                      'and Cut on obscured selections to protect the secret.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    _labeledFieldRow(
                      label: 'Password (obscured)',
                      labelColor: const Color(0xFF134E4A),
                      child: CupertinoTextField(
                        controller: passwordController,
                        selectionControls: cupertinoDesktopTextSelectionControls,
                        obscureText: true,
                        style: const TextStyle(fontSize: 13.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFF5EEAD4)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _labeledFieldRow(
                      label: 'Email',
                      labelColor: const Color(0xFF134E4A),
                      child: CupertinoTextField(
                        controller: emailController,
                        selectionControls: cupertinoDesktopTextSelectionControls,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 13.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFF5EEAD4)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _labeledFieldRow(
                      label: 'Numeric (digits only)',
                      labelColor: const Color(0xFF134E4A),
                      child: CupertinoTextField(
                        controller: numericController,
                        selectionControls: cupertinoDesktopTextSelectionControls,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(fontSize: 13.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFF5EEAD4)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _labeledFieldRow(
                      label: 'Search-style placeholder',
                      labelColor: const Color(0xFF134E4A),
                      child: CupertinoTextField(
                        controller: searchController,
                        selectionControls: cupertinoDesktopTextSelectionControls,
                        placeholder: 'Search Tom Framework symbols...',
                        prefix: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Icon(
                            CupertinoIcons.search,
                            color: Color(0xFF0D9488),
                            size: 16.0,
                          ),
                        ),
                        style: const TextStyle(fontSize: 13.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFF5EEAD4)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCFBF1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Look for: the password field intentionally hides Copy/Cut on '
                        'a selection. The numeric field rejects pasted non-digit content '
                        'because the FilteringTextInputFormatter still applies after '
                        'Paste runs through the desktop toolbar handler.',
                        style: TextStyle(fontSize: 12.5, color: Color(0xFF134E4A)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 9 — BUILD HOOKS
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F2),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFFDA4AF), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE11D48),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '9',
                            style: TextStyle(
                              color: Color(0xFFFFF1F2),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Build hooks: buildToolbar, buildHandle, action handlers',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF881337),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: the methods CupertinoDesktopTextSelectionControls '
                      'overrides on TextSelectionControls and what each one is responsible for. '
                      'A live editable field accompanies the table so the hooks are '
                      'actually exercised when the user interacts.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    _hookCard(
                      title: 'buildToolbar',
                      description:
                          'Renders the horizontal menu strip above the selection. '
                          'Returns a widget composed of CupertinoButton-styled '
                          'menu items, sized to the available viewport.',
                      colorMain: const Color(0xFFE11D48),
                      colorBg: const Color(0xFFFFE4E6),
                    ),
                    _hookCard(
                      title: 'buildHandle',
                      description:
                          'Returns SizedBox.shrink() — desktop selection has no draggable '
                          'handles, so the handle paint area is intentionally empty.',
                      colorMain: const Color(0xFFE11D48),
                      colorBg: const Color(0xFFFFE4E6),
                    ),
                    _hookCard(
                      title: 'getHandleAnchor',
                      description:
                          'Returns Offset.zero for every TextSelectionHandleType because '
                          'no handle is drawn — the anchor coordinate is moot.',
                      colorMain: const Color(0xFFE11D48),
                      colorBg: const Color(0xFFFFE4E6),
                    ),
                    _hookCard(
                      title: 'getHandleSize',
                      description:
                          'Returns Size.zero — desktop draws no handle bubble, so it '
                          'occupies no layout space below the selection.',
                      colorMain: const Color(0xFFE11D48),
                      colorBg: const Color(0xFFFFE4E6),
                    ),
                    _hookCard(
                      title: 'handleCopy / handleCut / handlePaste / handleSelectAll',
                      description:
                          'Inherited from TextSelectionControls. The desktop toolbar '
                          'invokes these on the supplied delegate to mutate the field\'s '
                          'TextEditingValue and write to the system clipboard.',
                      colorMain: const Color(0xFFE11D48),
                      colorBg: const Color(0xFFFFE4E6),
                    ),
                    const SizedBox(height: 10.0),
                    CupertinoTextField(
                      controller: lookupController,
                      selectionControls: cupertinoDesktopTextSelectionControls,
                      style: const TextStyle(fontSize: 13.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFFDA4AF)),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Try: select "polymorphism" with the mouse, watch buildToolbar '
                      'paint a strip; press Cut from the menu and observe handleCut '
                      'fire on the controls\' delegate.',
                      style: TextStyle(fontSize: 12.0, color: Color(0xFF881337)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 10 — EMPTY FIELD CORNER CASE
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFA78BFA), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6D28D9),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '10',
                            style: TextStyle(
                              color: Color(0xFFF5F3FF),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Empty field & paste-only menu',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4C1D95),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: an empty editable field still uses the desktop '
                      'controls. Right-clicking (or long-pressing on touch) shows a '
                      'reduced toolbar with Paste and Select All, since there is no '
                      'selection content to Copy or Cut.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    CupertinoTextField(
                      controller: emptyController,
                      selectionControls: cupertinoDesktopTextSelectionControls,
                      placeholder: 'Right-click in this empty field...',
                      style: const TextStyle(fontSize: 13.0),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFA78BFA)),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE9FE),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Look for: a paste-only strip. The controls object decides which '
                        'buttons to render based on TextSelectionDelegate state, not on '
                        'a separate flag passed by the field.',
                        style: TextStyle(fontSize: 12.5, color: Color(0xFF4C1D95)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 11 — WHY EXPLICITLY PASS THE SINGLETON
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFAEB),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFFDE68A), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFCA8A04),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '11',
                            style: TextStyle(
                              color: Color(0xFFFFFAEB),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Why pass cupertinoDesktopTextSelectionControls explicitly?',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF713F12),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'What this shows: prose that explains the three legitimate reasons '
                      'a developer would pin the desktop controls explicitly rather '
                      'than letting Flutter pick.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    _reasonCard(
                      number: 'A',
                      title: 'Force desktop UX on touch hardware',
                      body:
                          'Hybrid devices (e.g. Surface, Chromebook with touch) where '
                          'you want the predictable menu strip even when running in '
                          'tablet mode. Pin the singleton so the platform default '
                          'cannot toggle behind your back.',
                    ),
                    _reasonCard(
                      number: 'B',
                      title: 'Stable widget tests',
                      body:
                          'In widget tests, Flutter\'s default platform may differ '
                          'between CI runners. Passing cupertinoDesktopTextSelectionControls '
                          'pins the toolbar shape so finder-by-text expectations stay '
                          'deterministic.',
                    ),
                    _reasonCard(
                      number: 'C',
                      title: 'Custom CupertinoTextField wrappers',
                      body:
                          'Your design system may always render the desktop strip '
                          'regardless of platform. Passing the singleton from a '
                          'wrapper ensures the look-and-feel is uniform across all '
                          'consumers of the wrapper.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // SCENARIO 12 — CHEAT SHEET
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF111827),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF38BDF8),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            '12',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        const Expanded(
                          child: Text(
                            'Cheat sheet',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF1F5F9),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    _cheatRow('singleton', 'cupertinoDesktopTextSelectionControls'),
                    _cheatRow('class', 'CupertinoDesktopTextSelectionControls'),
                    _cheatRow('library', 'package:flutter/cupertino.dart'),
                    _cheatRow('parent', 'TextSelectionControls (mixin/abstract)'),
                    _cheatRow('handle', 'none — getHandleSize() = Size.zero'),
                    _cheatRow('toolbar', 'horizontal menu strip above caret'),
                    _cheatRow('default on', 'macOS / Linux / Windows desktop'),
                    _cheatRow('use with', 'CupertinoTextField.selectionControls'),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F2937),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'Tip: this demo deliberately passes selectionControls on every '
                        'CupertinoTextField so the binding to the desktop singleton is '
                        'never ambiguous. In production code, you can omit the parameter '
                        'and let Flutter choose — it will pick this exact singleton on '
                        'desktop platforms.',
                        style: TextStyle(
                          fontSize: 12.0,
                          height: 1.4,
                          color: Color(0xFFCBD5F5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ============================================================
              // FOOTER
              // ============================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Demo complete',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Probed ${probeScales.length} text scales, rendered '
                      '${capabilityRows.length} capability states, and instantiated '
                      '12 live CupertinoTextField widgets bound to '
                      'cupertinoDesktopTextSelectionControls.',
                      style: const TextStyle(
                        fontSize: 12.5,
                        height: 1.4,
                        color: Color(0xFF334155),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ===========================================================================
// SMALL HELPER WIDGETS — kept top-level so the harness file is self-contained.
// ===========================================================================

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: const Color(0x66FFFFFF)),
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 12.0, color: Color(0xFFE0E1DD)),
    ),
  );
}

Widget _labeledFieldRow({
  required String label,
  required Color labelColor,
  required Widget child,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: labelColor,
          ),
        ),
      ),
      child,
    ],
  );
}

Widget _capabilityChip(String label, bool active) {
  final Color background = active
      ? const Color(0xFF7C3AED)
      : const Color(0xFFE5E7EB);
  final Color foreground = active
      ? const Color(0xFFEDE9FE)
      : const Color(0xFF6B7280);
  final String prefix = active ? '+' : '-';
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      '$prefix $label',
      style: TextStyle(
        fontSize: 11.5,
        color: foreground,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _hookCard({
  required String title,
  required String description,
  required Color colorMain,
  required Color colorBg,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colorBg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 13.0,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: colorMain,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            description,
            style: const TextStyle(fontSize: 12.0, height: 1.4),
          ),
        ],
      ),
    ),
  );
}

Widget _reasonCard({
  required String number,
  required String title,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28.0,
            height: 28.0,
            decoration: const BoxDecoration(
              color: Color(0xFFCA8A04),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                color: Color(0xFFFFFAEB),
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF713F12),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 12.0,
                    height: 1.4,
                    color: Color(0xFF713F12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _cheatRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 88.0,
          child: Text(
            key,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF38BDF8),
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12.0,
              color: Color(0xFFF1F5F9),
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}
