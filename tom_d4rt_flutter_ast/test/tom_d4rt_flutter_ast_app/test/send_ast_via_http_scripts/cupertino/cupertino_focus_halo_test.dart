// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Live demo gallery - CupertinoFocusHalo focus indicators
// Six scenarios that demonstrate Cupertino focus halos around real widgets:
// buttons, text fields, segmented controls, switches, custom focusables, and
// a configuration matrix showing the visual effect of color/width/radius.
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  // ===========================================================================
  // SCENARIO 1 - BUTTONS WITH HALOS
  // ---------------------------------------------------------------------------
  // We allocate three FocusNodes that each own one CupertinoButton. The first
  // button in the row is rendered without focus to give us a visual baseline,
  // the second button shows the default Cupertino focus halo, the third paints
  // a thicker custom halo (a Container with a Border) so we can compare the
  // platform-default halo to a hand-rolled halo.
  // ===========================================================================
  final btnFilledNode = FocusNode(debugLabel: 'btnFilledNode');
  final btnTintedNode = FocusNode(debugLabel: 'btnTintedNode');
  final btnPlainNode = FocusNode(debugLabel: 'btnPlainNode');
  final btnExtraNode = FocusNode(debugLabel: 'btnExtraNode');

  // ===========================================================================
  // SCENARIO 2 - CUPERTINO TEXT FIELDS
  // ---------------------------------------------------------------------------
  // Three identical CupertinoTextFields. The first uses the default halo, the
  // second wraps the field in a Container that paints an explicit halo, the
  // third uses an AnimatedContainer driven by a FocusNode listener so the
  // halo can grow/shrink as focus is acquired or lost.
  // ===========================================================================
  final fieldDefaultNode = FocusNode(debugLabel: 'fieldDefaultNode');
  final fieldCustomNode = FocusNode(debugLabel: 'fieldCustomNode');
  final fieldAnimatedNode = FocusNode(debugLabel: 'fieldAnimatedNode');
  final fieldDefaultCtl = TextEditingController(text: 'default halo');
  final fieldCustomCtl = TextEditingController(text: 'custom halo');
  final fieldAnimatedCtl = TextEditingController(text: 'animated halo');

  // ===========================================================================
  // SCENARIO 3 - SEGMENTED CONTROL
  // ---------------------------------------------------------------------------
  // A CupertinoSegmentedControl with three children. We wrap the whole control
  // in a Focus widget that owns its own FocusNode so users can clearly see the
  // halo move with focus.
  // ===========================================================================
  final segmentNode = FocusNode(debugLabel: 'segmentNode');
  int segmentValue = 1;

  // ===========================================================================
  // SCENARIO 4 - CUPERTINO SWITCH ROW
  // ---------------------------------------------------------------------------
  // Four switches in a row. Each is wrapped in a Focus widget so we can drive
  // halo state from the demo with explicit prev/next buttons.
  // ===========================================================================
  final switch1Node = FocusNode(debugLabel: 'switch1Node');
  final switch2Node = FocusNode(debugLabel: 'switch2Node');
  final switch3Node = FocusNode(debugLabel: 'switch3Node');
  final switch4Node = FocusNode(debugLabel: 'switch4Node');

  // ===========================================================================
  // SCENARIO 5 - DIY HALO ON A CUSTOM FOCUSABLE
  // ---------------------------------------------------------------------------
  // Two custom focusable rectangles built from GestureDetector + Focus. The
  // left one paints a halo by hand using BoxDecoration. The right one mounts a
  // CupertinoButton so the comparison is direct.
  // ===========================================================================
  final diyNode = FocusNode(debugLabel: 'diyNode');
  final diyCompareNode = FocusNode(debugLabel: 'diyCompareNode');

  // ===========================================================================
  // SCENARIO 6 - HALO CONFIGURATION MATRIX
  // ---------------------------------------------------------------------------
  // Six identical CupertinoButtons placed inside Containers that paint halos
  // with different colours, widths, and border radii. The same FocusNode is
  // not shared - we want a static visual showing every parameter combo.
  // ===========================================================================
  final matrixNodes = <FocusNode>[
    FocusNode(debugLabel: 'matrix1'),
    FocusNode(debugLabel: 'matrix2'),
    FocusNode(debugLabel: 'matrix3'),
    FocusNode(debugLabel: 'matrix4'),
    FocusNode(debugLabel: 'matrix5'),
    FocusNode(debugLabel: 'matrix6'),
  ];

  print('CupertinoFocusHalo gallery executing');
  print('  scenario 1 nodes: filled=${btnFilledNode.debugLabel}, '
      'tinted=${btnTintedNode.debugLabel}, plain=${btnPlainNode.debugLabel}, '
      'extra=${btnExtraNode.debugLabel}');
  print('  scenario 2 nodes: default=${fieldDefaultNode.debugLabel}, '
      'custom=${fieldCustomNode.debugLabel}, animated=${fieldAnimatedNode.debugLabel}');
  print('  scenario 3 node:  segmented=${segmentNode.debugLabel}');
  print('  scenario 4 nodes: '
      's1=${switch1Node.debugLabel}, s2=${switch2Node.debugLabel}, '
      's3=${switch3Node.debugLabel}, s4=${switch4Node.debugLabel}');
  print('  scenario 5 nodes: diy=${diyNode.debugLabel}, '
      'compare=${diyCompareNode.debugLabel}');
  print('  scenario 6 nodes: ${matrixNodes.map((n) => n.debugLabel).toList()}');
  print('  total focus nodes registered: 17');

  // Halo configuration matrix data (used in scenario 6).
  final matrixCells = <Map<String, dynamic>>[
    {
      'color': CupertinoColors.systemBlue,
      'width': 2.0,
      'radius': 6.0,
      'caption': 'systemBlue / 2.0 / r6',
      'background': const Color(0xFFEFF7FF),
    },
    {
      'color': CupertinoColors.systemPink,
      'width': 3.0,
      'radius': 12.0,
      'caption': 'systemPink / 3.0 / r12',
      'background': const Color(0xFFFFF1F4),
    },
    {
      'color': CupertinoColors.systemGreen,
      'width': 4.0,
      'radius': 4.0,
      'caption': 'systemGreen / 4.0 / r4',
      'background': const Color(0xFFEEFBEF),
    },
    {
      'color': CupertinoColors.systemOrange,
      'width': 1.5,
      'radius': 18.0,
      'caption': 'systemOrange / 1.5 / r18',
      'background': const Color(0xFFFFF6EB),
    },
    {
      'color': CupertinoColors.systemPurple,
      'width': 5.0,
      'radius': 8.0,
      'caption': 'systemPurple / 5.0 / r8',
      'background': const Color(0xFFF6EFFF),
    },
    {
      'color': CupertinoColors.systemTeal,
      'width': 2.5,
      'radius': 24.0,
      'caption': 'systemTeal / 2.5 / r24',
      'background': const Color(0xFFEFFBFB),
    },
  ];

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoFocusHalo Gallery'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ================================================================
              // GALLERY HEADER
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0A84FF), Color(0xFF5E5CE6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CupertinoFocusHalo',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'Six live focus scenarios, real widgets, real focus nodes',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFFE5E5F0),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              // ================================================================
              // SCENARIO 1 - BUTTONS
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF7FF),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFB6D4FB), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _scenarioTitle(
                      number: '1',
                      title: 'Buttons with focus halos',
                      tint: const Color(0xFF0A84FF),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'CupertinoFocusHalo is the rounded outline that Cupertino '
                      'buttons paint around themselves when they have keyboard '
                      'focus. Press the focus shifters below to see the halo '
                      'jump from button to button.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'unfocused',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF8E8E93),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Focus(
                                focusNode: btnFilledNode,
                                child: CupertinoButton.filled(
                                  onPressed: () {},
                                  child: const Text('Filled'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'default halo',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0A84FF),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Focus(
                                focusNode: btnTintedNode,
                                child: CupertinoButton.tinted(
                                  onPressed: () {},
                                  child: const Text('Tinted'),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'custom halo',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFC7264E),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xFFC7264E),
                                    width: 3.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Focus(
                                  focusNode: btnPlainNode,
                                  child: CupertinoButton(
                                    onPressed: () {},
                                    child: const Text('Plain'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFCDD9EA)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Focus this button:',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Row(
                            children: [
                              Expanded(
                                child: CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  color: const Color(0xFFE3F0FF),
                                  onPressed: btnFilledNode.requestFocus,
                                  child: const Text(
                                    'Filled',
                                    style: TextStyle(
                                      color: Color(0xFF0A84FF),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              Expanded(
                                child: CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  color: const Color(0xFFE3F0FF),
                                  onPressed: btnTintedNode.requestFocus,
                                  child: const Text(
                                    'Tinted',
                                    style: TextStyle(
                                      color: Color(0xFF0A84FF),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              Expanded(
                                child: CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  color: const Color(0xFFE3F0FF),
                                  onPressed: btnPlainNode.requestFocus,
                                  child: const Text(
                                    'Plain',
                                    style: TextStyle(
                                      color: Color(0xFF0A84FF),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              Expanded(
                                child: CupertinoButton(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  color: const Color(0xFFFFE5EC),
                                  onPressed: btnExtraNode.requestFocus,
                                  child: const Text(
                                    'None',
                                    style: TextStyle(
                                      color: Color(0xFFC7264E),
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Look for: a soft blue ring (default) vs a thick red '
                      'ring (custom). Press tab/arrow keys with focus on the '
                      'page or use the focus buttons above.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6C6C70),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ================================================================
              // SCENARIO 2 - TEXT FIELDS
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF6EE),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFFFCFA8), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _scenarioTitle(
                      number: '2',
                      title: 'Text fields - default vs custom vs animated',
                      tint: const Color(0xFFFF8E26),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'CupertinoTextField paints its own halo through its '
                      'native decoration painter. We compare three identical '
                      'fields: default, manually outlined, and an animated '
                      'halo driven by a FocusNode listener.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    const Text(
                      'A. default halo',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8E5400),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    CupertinoTextField(
                      focusNode: fieldDefaultNode,
                      controller: fieldDefaultCtl,
                      placeholder: 'tap to focus',
                    ),
                    const SizedBox(height: 14.0),
                    const Text(
                      'B. custom Container halo (4px brand orange)',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8E5400),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFFF8E26),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: CupertinoTextField(
                        focusNode: fieldCustomNode,
                        controller: fieldCustomCtl,
                        placeholder: 'wrapped in halo container',
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    const Text(
                      'C. AnimatedContainer driven by FocusNode',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8E5400),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Builder(
                      builder: (ctx) {
                        return AnimatedBuilder(
                          animation: fieldAnimatedNode,
                          builder: (ctx2, _) {
                            final focused = fieldAnimatedNode.hasFocus;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 220),
                              curve: Curves.easeOut,
                              padding: EdgeInsets.all(focused ? 4.0 : 1.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: focused
                                      ? const Color(0xFFFF8E26)
                                      : const Color(0x00FF8E26),
                                  width: focused ? 3.0 : 1.0,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: CupertinoTextField(
                                focusNode: fieldAnimatedNode,
                                controller: fieldAnimatedCtl,
                                placeholder: 'animated halo',
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFFFE0C6),
                            onPressed: fieldDefaultNode.requestFocus,
                            child: const Text(
                              'focus A',
                              style: TextStyle(
                                color: Color(0xFF8E5400),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFFFE0C6),
                            onPressed: fieldCustomNode.requestFocus,
                            child: const Text(
                              'focus B',
                              style: TextStyle(
                                color: Color(0xFF8E5400),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFFFE0C6),
                            onPressed: fieldAnimatedNode.requestFocus,
                            child: const Text(
                              'focus C',
                              style: TextStyle(
                                color: Color(0xFF8E5400),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Look for: a static border (B) vs a border that grows '
                      'when C receives focus.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6C4400),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ================================================================
              // SCENARIO 3 - SEGMENTED CONTROL
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEFBEF),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFA8E0AC), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _scenarioTitle(
                      number: '3',
                      title: 'Segmented control with travelling halo',
                      tint: const Color(0xFF34C759),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'CupertinoSegmentedControl is a single focusable widget. '
                      'When focused, the entire control gets a halo. The two '
                      'on-screen buttons drive focus on/off so the halo is '
                      'visible without needing a real keyboard.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: AnimatedBuilder(
                        animation: segmentNode,
                        builder: (ctx, _) {
                          final focused = segmentNode.hasFocus;
                          return Container(
                            padding: EdgeInsets.all(focused ? 6.0 : 0.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: focused
                                    ? const Color(0xFF34C759)
                                    : const Color(0x0034C759),
                                width: focused ? 3.0 : 1.0,
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Focus(
                              focusNode: segmentNode,
                              child: CupertinoSegmentedControl<int>(
                                groupValue: segmentValue,
                                onValueChanged: (v) {
                                  segmentValue = v;
                                },
                                children: const <int, Widget>{
                                  0: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 6.0,
                                    ),
                                    child: Text('Day'),
                                  ),
                                  1: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 6.0,
                                    ),
                                    child: Text('Week'),
                                  ),
                                  2: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                      vertical: 6.0,
                                    ),
                                    child: Text('Month'),
                                  ),
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFCFEBD3),
                            onPressed: segmentNode.requestFocus,
                            child: const Text(
                              'focus segments',
                              style: TextStyle(
                                color: Color(0xFF136B23),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFCFEBD3),
                            onPressed: segmentNode.unfocus,
                            child: const Text(
                              'unfocus',
                              style: TextStyle(
                                color: Color(0xFF136B23),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Look for: a green ring growing around the segmented '
                      'control when focus is requested, and shrinking back '
                      'when unfocus is invoked.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF136B23),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ================================================================
              // SCENARIO 4 - SWITCHES
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6EFFF),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFCDB7F2), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _scenarioTitle(
                      number: '4',
                      title: 'Switch row',
                      tint: const Color(0xFFAF52DE),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'CupertinoSwitch shows a halo via the platform painter '
                      'when focused. We wrap each switch in a Focus widget '
                      'and a halo Container so we can drive halo state from '
                      'the demo without an attached keyboard.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _haloSwitch(
                          node: switch1Node,
                          value: true,
                          tint: const Color(0xFFAF52DE),
                        ),
                        _haloSwitch(
                          node: switch2Node,
                          value: false,
                          tint: const Color(0xFFAF52DE),
                        ),
                        _haloSwitch(
                          node: switch3Node,
                          value: true,
                          tint: const Color(0xFFAF52DE),
                        ),
                        _haloSwitch(
                          node: switch4Node,
                          value: false,
                          tint: const Color(0xFFAF52DE),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFE0CFF5),
                            onPressed: switch1Node.requestFocus,
                            child: const Text(
                              'focus 1',
                              style: TextStyle(
                                color: Color(0xFF6C2E9C),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFE0CFF5),
                            onPressed: switch2Node.requestFocus,
                            child: const Text(
                              'focus 2',
                              style: TextStyle(
                                color: Color(0xFF6C2E9C),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFE0CFF5),
                            onPressed: switch3Node.requestFocus,
                            child: const Text(
                              'focus 3',
                              style: TextStyle(
                                color: Color(0xFF6C2E9C),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFE0CFF5),
                            onPressed: switch4Node.requestFocus,
                            child: const Text(
                              'focus 4',
                              style: TextStyle(
                                color: Color(0xFF6C2E9C),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Look for: only the active switch is wrapped in a '
                      'visible halo. Each focus button transfers ownership.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6C2E9C),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ================================================================
              // SCENARIO 5 - DIY HALO
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFFBFB),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFA0DEDB), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _scenarioTitle(
                      number: '5',
                      title: 'DIY halo on a custom focusable',
                      tint: const Color(0xFF30B0C7),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'A bare GestureDetector does not show a halo. Wrap it '
                      'in a Focus widget and paint a halo by hand for an '
                      'exact equivalent of CupertinoFocusHalo. Sit a real '
                      'CupertinoButton next to it for a side-by-side compare.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'DIY halo',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1B7B89),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              AnimatedBuilder(
                                animation: diyNode,
                                builder: (ctx, _) {
                                  final focused = diyNode.hasFocus;
                                  return Container(
                                    padding: EdgeInsets.all(focused ? 4.0 : 0.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: focused
                                            ? const Color(0xFF30B0C7)
                                            : const Color(0x0030B0C7),
                                        width: focused ? 3.0 : 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(14.0),
                                    ),
                                    child: Focus(
                                      focusNode: diyNode,
                                      child: GestureDetector(
                                        onTap: diyNode.requestFocus,
                                        child: Container(
                                          width: 130.0,
                                          height: 56.0,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF30B0C7),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'tap me',
                                              style: TextStyle(
                                                color: Color(0xFFFFFFFF),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            children: [
                              const Text(
                                'Cupertino default',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1B7B89),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Focus(
                                focusNode: diyCompareNode,
                                child: CupertinoButton.filled(
                                  onPressed: () {},
                                  child: const Text('Filled'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFCDEBED),
                            onPressed: diyNode.requestFocus,
                            child: const Text(
                              'focus DIY',
                              style: TextStyle(
                                color: Color(0xFF1B7B89),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            color: const Color(0xFFCDEBED),
                            onPressed: diyCompareNode.requestFocus,
                            child: const Text(
                              'focus default',
                              style: TextStyle(
                                color: Color(0xFF1B7B89),
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Look for: both halos draw an outer ring. The DIY one '
                      'is hand-painted, the right one is the platform halo.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF1B7B89),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16.0),

              // ================================================================
              // SCENARIO 6 - HALO MATRIX
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F4),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFF6BBC8), width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _scenarioTitle(
                      number: '6',
                      title: 'Halo configuration matrix',
                      tint: const Color(0xFFFF375F),
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'The same CupertinoButton is rendered in six cells, '
                      'each with a different halo color, stroke width, and '
                      'border radius. The captions document the parameters.',
                      style: TextStyle(fontSize: 13.0, height: 1.4),
                    ),
                    const SizedBox(height: 14.0),
                    for (int row = 0; row < 3; row++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _haloMatrixCell(
                                node: matrixNodes[row * 2],
                                color: matrixCells[row * 2]['color'] as Color,
                                width: matrixCells[row * 2]['width'] as double,
                                radius:
                                    matrixCells[row * 2]['radius'] as double,
                                caption:
                                    matrixCells[row * 2]['caption'] as String,
                                background: matrixCells[row * 2]['background']
                                    as Color,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: _haloMatrixCell(
                                node: matrixNodes[row * 2 + 1],
                                color:
                                    matrixCells[row * 2 + 1]['color'] as Color,
                                width:
                                    matrixCells[row * 2 + 1]['width'] as double,
                                radius:
                                    matrixCells[row * 2 + 1]['radius']
                                        as double,
                                caption:
                                    matrixCells[row * 2 + 1]['caption']
                                        as String,
                                background:
                                    matrixCells[row * 2 + 1]['background']
                                        as Color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 4.0),
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 6.0,
                      children: [
                        for (int i = 0; i < matrixNodes.length; i++)
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 6.0,
                            ),
                            color: const Color(0xFFFFD9DF),
                            onPressed: matrixNodes[i].requestFocus,
                            child: Text(
                              'focus #${i + 1}',
                              style: const TextStyle(
                                color: Color(0xFFC1183B),
                                fontSize: 11.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      'Look for: the focused cell shows its halo at the '
                      'configured colour, width and radius. Compare cells to '
                      'see how each parameter changes the visual.',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFC1183B),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24.0),

              // ================================================================
              // FOOTER
              // ================================================================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gallery summary',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Text(
                      'Six live scenarios - buttons, text fields, segmented, '
                      'switches, DIY focusable, configuration matrix.',
                      style: TextStyle(
                        color: Color(0xFFEBEBF5),
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Tip: pressing tab or arrow keys in a real keyboard '
                      'environment moves focus across all 17 nodes wired up '
                      'in this demo, painting halos as it goes.',
                      style: TextStyle(
                        color: Color(0xFFAEAEB2),
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),
              const Center(
                child: Text(
                  'CupertinoFocusHalo - live focus gallery',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF8E8E93)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HELPERS
// =============================================================================

Widget _scenarioTitle({
  required String number,
  required String title,
  required Color tint,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22.0,
          height: 22.0,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: tint,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
      ],
    ),
  );
}

Widget _haloSwitch({
  required FocusNode node,
  required bool value,
  required Color tint,
}) {
  return AnimatedBuilder(
    animation: node,
    builder: (ctx, _) {
      final focused = node.hasFocus;
      return Container(
        padding: EdgeInsets.all(focused ? 4.0 : 0.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: focused ? tint : const Color(0x00000000),
            width: focused ? 2.5 : 1.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Focus(
          focusNode: node,
          child: CupertinoSwitch(
            value: value,
            onChanged: (_) {},
            activeTrackColor: tint,
          ),
        ),
      );
    },
  );
}

Widget _haloMatrixCell({
  required FocusNode node,
  required Color color,
  required double width,
  required double radius,
  required String caption,
  required Color background,
}) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0x11000000)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: node,
          builder: (ctx, _) {
            final focused = node.hasFocus;
            return Container(
              padding: EdgeInsets.all(focused ? width + 1.0 : 1.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: focused ? color : const Color(0x00000000),
                  width: focused ? width : 1.0,
                ),
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Focus(
                focusNode: node,
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 8.0,
                  ),
                  color: const Color(0xFFFFFFFF),
                  onPressed: node.requestFocus,
                  child: Text(
                    'Press',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 8.0),
        Text(
          caption,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.5,
            fontFamily: 'monospace',
            color: Color(0xFF3A3A3C),
          ),
        ),
      ],
    ),
  );
}

// Reference to LogicalKeyboardKey to keep services import live for d4rt
// inspection - real focus traversal in this demo is driven by buttons, but
// keyboard travel is the underlying use case.
// ignore: unused_element
final LogicalKeyboardKey _kReferencedKey = LogicalKeyboardKey.tab;
