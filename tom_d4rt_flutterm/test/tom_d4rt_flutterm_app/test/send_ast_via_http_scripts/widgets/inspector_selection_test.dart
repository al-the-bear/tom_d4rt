// ignore_for_file: avoid_print
// D4rt deep demo: InspectorSelection — tracks the currently selected widget
// and render object in the Flutter widget inspector. When a developer taps
// a widget in the inspector overlay, InspectorSelection stores the chosen
// RenderObject, its bounding box, and provides the transform needed to
// paint the selection highlight.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Teal / Cyan palette ───
  const Color teal = Color(0xFF0D9488);
  const Color cyan = Color(0xFF06B6D4);
  const Color deepTeal = Color(0xFF134E4A);
  const Color paleAqua = Color(0xFFCCFBF1);
  const Color turquoise = Color(0xFF14B8A6);
  const Color seafoam = Color(0xFFF0FDFA);
  const Color ocean = Color(0xFF0F766E);
  const Color lagoon = Color(0xFF22D3EE);
  const Color malachite = Color(0xFF99F6E4);
  const Color jade = Color(0xFF115E59);

  print('===== INSPECTOR SELECTION DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepTeal, jade],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepTeal.withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: teal,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: turquoise, width: 1.5),
            ),
            child: Center(
              child: Text(number,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3)),
          ),
        ],
      ),
    );
  }

  Widget noteBox(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: seafoam,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: malachite),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepTeal.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget infoCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: malachite),
        boxShadow: [
          BoxShadow(
            color: teal.withValues(alpha: 0.07),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
            decoration: BoxDecoration(
              color: paleAqua,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepTeal)),
          ),
          Padding(padding: const EdgeInsets.all(12), child: content),
        ],
      ),
    );
  }

  Widget tag(String label, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label,
          style:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: fg)),
    );
  }

  Widget dataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 160,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepTeal)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: jade)),
          ),
        ],
      ),
    );
  }

  Widget colorSwatch(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: deepTeal.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepTeal),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget progressBar(String label, double fraction, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: deepTeal)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: malachite.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(3.5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectionBox(String widgetName, double width, double height,
      bool selected, Color borderColor) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: selected
            ? borderColor.withValues(alpha: 0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: selected ? borderColor : malachite,
          width: selected ? 3 : 1,
        ),
        boxShadow: selected
            ? [
                BoxShadow(
                    color: borderColor.withValues(alpha: 0.25),
                    blurRadius: 8,
                    spreadRadius: 1)
              ]
            : [],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? Icons.gps_fixed : Icons.crop_free,
              size: 16,
              color: selected ? borderColor : ocean.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 2),
            Text(widgetName,
                style: TextStyle(
                    fontSize: 9,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.normal,
                    color: selected ? borderColor : ocean),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget boundingRect(
      String label, double top, double left, double w, double h, Color color) {
    return Stack(
      children: [
        Container(
          width: 200,
          height: 120,
          decoration: BoxDecoration(
            color: seafoam,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: malachite),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Stack(
              children: [
                Positioned(
                  top: top,
                  left: left,
                  child: Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15),
                      border: Border.all(color: color, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 8,
          child: Text(label,
              style: TextStyle(fontSize: 9, color: deepTeal)),
        ),
      ],
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'InspectorSelection is the model that tracks which widget or '
          'render object a developer has selected in the Flutter widget '
          'inspector. It stores the current RenderObject reference, its '
          'bounding rectangle in global coordinates, and the transform '
          'matrix needed to paint the selection overlay.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Mutable selection model'),
              dataRow('Package', 'flutter/widgets (widgetInspector)'),
              dataRow('Purpose', 'Track selected render object'),
              dataRow('Consumers', 'InspectorOverlay, DevTools'),
              dataRow('State', 'Single selected object at a time'),
            ],
          )),
      infoCard(
          'Key Responsibilities',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Store selection', 'Current RenderObject reference'),
              dataRow('Bounding box', 'Global-space rectangle'),
              dataRow('Transform', 'Matrix4 for overlay painting'),
              dataRow('Candidates', 'Hit test result chain'),
              dataRow('Notify', 'Update overlay when changed'),
            ],
          )),
    ],
  );

  // ─── Section 2: Selection Model ───
  print('[Section 2] Selection Model');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Selection Model'),
      noteBox(
          'InspectorSelection holds a mutable reference that changes each '
          'time the developer taps a different widget or navigates the '
          'tree in DevTools.'),
      infoCard(
          'Model Fields',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('current', 'RenderObject? — selected render obj'),
              dataRow('currentElement', 'Element? — selected element'),
              dataRow('candidates', 'List<RenderObject> — hit chain'),
              dataRow('index', 'int — index in candidates list'),
              dataRow('active', 'bool — selection is valid'),
            ],
          )),
      infoCard(
          'Selection Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectionBox('Scaffold', 60, 60, false, teal),
                  selectionBox('Column', 60, 60, false, teal),
                  selectionBox('Padding', 60, 60, true, teal),
                  selectionBox('Text', 60, 60, false, teal),
                ],
              ),
              const SizedBox(height: 8),
              dataRow('Selected', 'Padding — highlighted with border'),
              dataRow('Others', 'Standard appearance, selectable'),
            ],
          )),
    ],
  );

  // ─── Section 3: Current vs Candidate ───
  print('[Section 3] Current vs Candidate');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Current vs Candidates'),
      noteBox(
          'When a tap occurs, the hit test returns a chain of RenderObjects '
          'from the deepest to the root. The candidates list holds all of '
          'them, and the developer can cycle through to choose which one.'),
      infoCard(
          'Candidate Chain',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  selectionBox('RenderParagraph', 80, 50, true, cyan),
                  Icon(Icons.arrow_back, size: 14, color: teal),
                  selectionBox('RenderPadding', 80, 50, false, teal),
                  Icon(Icons.arrow_back, size: 14, color: teal),
                  selectionBox('RenderFlex', 80, 50, false, teal),
                ],
              ),
              const SizedBox(height: 8),
              dataRow('Index 0 (deepest)', 'RenderParagraph — current'),
              dataRow('Index 1', 'RenderPadding'),
              dataRow('Index 2', 'RenderFlex'),
              dataRow('Cycling', 'Arrow keys or DevTools up/down'),
            ],
          )),
      infoCard(
          'Index Navigation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Move deeper', 'index-- (towards leaf)'),
              dataRow('Move shallower', 'index++ (towards root)'),
              dataRow('Bounds check', 'Clamped to 0..candidates.length-1'),
              dataRow('Auto-select', 'First candidate selected by default'),
            ],
          )),
    ],
  );

  // ─── Section 4: Hit Testing ───
  print('[Section 4] Hit Testing');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Hit Testing for Selection'),
      noteBox(
          'The inspector overlay intercepts taps and performs a hit test '
          'against the render tree to find which objects are under the '
          'tap position.'),
      infoCard(
          'Hit Test Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Tap at (x, y)', 'User taps on inspector overlay'),
              dataRow('2. hitTest()', 'Render tree traversal'),
              dataRow('3. Collect results', 'All render objects hit'),
              dataRow('4. Filter', 'Remove invisible/zero-size objects'),
              dataRow('5. Set candidates', 'Store in selection model'),
              dataRow('6. Select deepest', 'Auto-select index 0'),
            ],
          )),
      infoCard(
          'Hit Test Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: seafoam,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: malachite),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 10, left: 10,
                      child: Container(
                        width: 180, height: 80,
                        decoration: BoxDecoration(
                          color: teal.withValues(alpha: 0.08),
                          border: Border.all(color: teal.withValues(alpha: 0.3)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text('RenderFlex', style: TextStyle(fontSize: 8, color: teal)),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30, left: 30,
                      child: Container(
                        width: 100, height: 50,
                        decoration: BoxDecoration(
                          color: cyan.withValues(alpha: 0.12),
                          border: Border.all(color: cyan.withValues(alpha: 0.5)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text('RenderPadding', style: TextStyle(fontSize: 8, color: cyan)),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 45, left: 50,
                      child: Container(
                        width: 50, height: 25,
                        decoration: BoxDecoration(
                          color: turquoise.withValues(alpha: 0.2),
                          border: Border.all(color: turquoise, width: 2),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: Text('Text', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w700, color: turquoise)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50, left: 65,
                      child: Icon(Icons.my_location, size: 12, color: lagoon),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              dataRow('Tap point', 'Blue crosshair on Text'),
              dataRow('Hit results', 'Text → Padding → Flex'),
            ],
          )),
    ],
  );

  // ─── Section 5: Bounding Box ───
  print('[Section 5] Bounding Box');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Bounding Box & Bounds'),
      noteBox(
          'InspectorSelection computes the bounding rectangle of the '
          'selected render object in global coordinates, used to paint '
          'the selection highlight overlay.'),
      infoCard(
          'Bounding Box Properties',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Rect', 'Left, top, width, height'),
              dataRow('Global coords', 'Relative to screen origin'),
              dataRow('Transform', 'Matrix4 from local to global'),
              dataRow('Padding', 'Optional padding around selection'),
            ],
          )),
      infoCard(
          'Bounding Box Examples',
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              boundingRect('Small widget', 30, 60, 60, 40, teal),
              const SizedBox(width: 8),
              boundingRect('Full-width', 10, 10, 180, 30, cyan),
            ],
          )),
    ],
  );

  // ─── Section 6: Selection Highlight Painting ───
  print('[Section 6] Highlight Painting');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Selection Highlight Painting'),
      noteBox(
          'The inspector overlay uses the selection\'s bounding box and '
          'transform to paint a colored rectangle around the selected '
          'widget, with dimension labels.'),
      infoCard(
          'Highlight Components',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Blue border', 'Selection rectangle outline'),
              dataRow('Size label', 'Width x Height displayed'),
              dataRow('Description', 'Widget type name shown'),
              dataRow('Margin lines', 'Optional margin visualization'),
              dataRow('Padding fill', 'Semi-transparent padding area'),
            ],
          )),
      infoCard(
          'Highlight Mockup',
          Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: seafoam,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 160,
                    height: 80,
                    decoration: BoxDecoration(
                      color: cyan.withValues(alpha: 0.08),
                      border: Border.all(color: cyan, width: 2),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: -14,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            color: cyan,
                            child: const Text('Padding',
                                style: TextStyle(fontSize: 9, color: Colors.white)),
                          ),
                        ),
                        Positioned(
                          bottom: -14,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            color: cyan,
                            child: const Text('160.0 × 80.0',
                                style: TextStyle(fontSize: 9, color: Colors.white)),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: turquoise.withValues(alpha: 0.5),
                                  style: BorderStyle.solid),
                            ),
                            child: Center(
                              child: Text('Content',
                                  style: TextStyle(
                                      fontSize: 10, color: deepTeal)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    ],
  );

  // ─── Section 7: Transform Matrix ───
  print('[Section 7] Transform Matrix');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Transform Matrix'),
      noteBox(
          'The selection stores a Matrix4 transform that maps from the '
          'render object\'s local coordinate space to the global screen '
          'coordinates, accounting for all ancestor transforms.'),
      infoCard(
          'Transform Composition',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('getTransformTo(null)', 'From local to global'),
              dataRow('Translation', 'Position offset from parent'),
              dataRow('Rotation', 'If Transform widget used'),
              dataRow('Scale', 'If scaled by ancestor'),
              dataRow('Composition', 'Multiply up the tree'),
            ],
          )),
      infoCard(
          'Transform Use Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Overlay painting', 'Position highlight correctly'),
              dataRow('Rotated widgets', 'Selection follows rotation'),
              dataRow('Scaled content', 'Bounds scale proportionally'),
              dataRow('Scrolled content', 'Accounts for scroll offset'),
            ],
          )),
    ],
  );

  // ─── Section 8: Selection Events ───
  print('[Section 8] Selection Events');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Selection Events'),
      noteBox(
          'Changes to the selection trigger updates in both the overlay '
          'rendering and the DevTools panel display.'),
      infoCard(
          'Event Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Selection changed', 'New render object assigned'),
              dataRow('Overlay repaint', 'Paint new highlight rect'),
              dataRow('DevTools notify', 'Send updated selection info'),
              dataRow('Properties update', 'New diagnostics displayed'),
              dataRow('Tree focus', 'Tree view scrolls to node'),
            ],
          )),
      infoCard(
          'Notification Mechanism',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('WidgetInspectorService', 'Manages selection state'),
              dataRow('selectionChangedCallback', 'Called on change'),
              dataRow('Service extension', 'Notifies DevTools client'),
              dataRow('Overlay.markNeedsPaint', 'Triggers visual update'),
            ],
          )),
    ],
  );

  // ─── Section 9: Overlay Integration ───
  print('[Section 9] Overlay Integration');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Overlay Integration'),
      noteBox(
          'InspectorSelection is consumed by the InspectorOverlay which '
          'paints the selection visualization on top of the application.'),
      infoCard(
          'Overlay Layers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('App layer', 'Normal rendering'),
              dataRow('Overlay layer', 'Selection highlight + labels'),
              dataRow('Toolbar layer', 'Inspector buttons'),
              dataRow('Z-order', 'Selection between app & toolbar'),
            ],
          )),
      infoCard(
          'Paint Pipeline',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Read selection', 'Get current RenderObject'),
              dataRow('2. Get bounds', 'selection.currentElement.renderObject'),
              dataRow('3. Get transform', 'getTransformTo(null)'),
              dataRow('4. Apply transform', 'Canvas transform with matrix'),
              dataRow('5. Paint rect', 'Blue outline + size label'),
            ],
          )),
    ],
  );

  // ─── Section 10: Programmatic Selection ───
  print('[Section 10] Programmatic Selection');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Programmatic Selection'),
      noteBox(
          'Selection can also be driven programmatically from DevTools, '
          'not just from tap interactions in the overlay.'),
      infoCard(
          'Programmatic Selection Methods',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('setSelection()', 'Set from DevTools tree click'),
              dataRow('selectByElement', 'Select by Element reference'),
              dataRow('selectByObject', 'Select by RenderObject ref'),
              dataRow('clear()', 'Remove current selection'),
            ],
          )),
      infoCard(
          'DevTools Workflow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Tree view click', 'User clicks node in DevTools'),
              dataRow('ID lookup', 'Find object by inspector ref ID'),
              dataRow('Set selection', 'Programmatic selection update'),
              dataRow('Overlay update', 'Highlight appears on device'),
              dataRow('Properties', 'Panel shows diagnostics'),
            ],
          )),
    ],
  );

  // ─── Section 11: Selection Clearing ───
  print('[Section 11] Selection Clearing');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Selection Clearing'),
      noteBox(
          'The selection can be cleared when the inspector is dismissed, '
          'when the selected widget unmounts, or explicitly by the user.'),
      infoCard(
          'Clear Triggers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Inspector closed', 'Overlay dismissed'),
              dataRow('Widget unmounts', 'Element removed from tree'),
              dataRow('App navigation', 'Route change removes widget'),
              dataRow('Explicit clear', 'User presses escape/deselect'),
              dataRow('Hot reload', 'Widget tree rebuilt'),
            ],
          )),
      infoCard(
          'Cleared State',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  selectionBox('Scaffold', 60, 60, false, teal),
                  selectionBox('Column', 60, 60, false, teal),
                  selectionBox('Padding', 60, 60, false, teal),
                  selectionBox('Text', 60, 60, false, teal),
                ],
              ),
              const SizedBox(height: 8),
              dataRow('State', 'No selection — all items neutral'),
              dataRow('Overlay', 'No highlight painted'),
            ],
          )),
    ],
  );

  // ─── Section 12: Multi-candidate Cycling ───
  print('[Section 12] Multi-candidate Cycling');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Multi-candidate Cycling'),
      noteBox(
          'When multiple render objects overlap at a tap point, the '
          'developer can cycle through them to select the desired one.'),
      infoCard(
          'Cycling Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Initial', 'Deepest (most specific) selected'),
              dataRow('Up arrow', 'Select parent render object'),
              dataRow('Down arrow', 'Select child render object'),
              dataRow('Wrapping', 'Stops at boundaries'),
            ],
          )),
      infoCard(
          'Cycling Visualization',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  selectionBox('Leaf', 70, 50, true, lagoon),
                  Icon(Icons.swap_horiz, size: 18, color: teal),
                  selectionBox('Middle', 70, 50, false, teal),
                  Icon(Icons.swap_horiz, size: 18, color: teal),
                  selectionBox('Root', 70, 50, false, teal),
                ],
              ),
              const SizedBox(height: 6),
              dataRow('Step 1', 'Leaf selected (deepest hit)'),
              dataRow('Step 2→', 'Middle selected'),
              dataRow('Step 3→', 'Root selected'),
            ],
          )),
    ],
  );

  // ─── Section 13: Edge Cases ───
  print('[Section 13] Edge Cases');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Edge Cases'),
      noteBox(
          'Several edge cases can make selection tricky — zero-size '
          'widgets, off-screen content, and transformed elements.'),
      infoCard(
          'Tricky Selections',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Zero-size widget', 'SizedBox.shrink — no visible area'),
              dataRow('Overflow widget', 'Rendered outside parent bounds'),
              dataRow('Opacity 0', 'Invisible but still hit-testable'),
              dataRow('Rotated 180°', 'Transform affects bounding box'),
              dataRow('Off-screen', 'Scrolled out — no paint bounds'),
            ],
          )),
      infoCard(
          'Handling Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Zero-size', 'Show marker dot at position'),
              dataRow('Overflow', 'Clip highlight to visible area'),
              dataRow('Opacity 0', 'Still highlightable'),
              dataRow('Rotate', 'Use transformed bounds'),
              dataRow('Off-screen', 'Scroll into view first'),
            ],
          )),
    ],
  );

  // ─── Section 14: Debugging Selection ───
  print('[Section 14] Debugging Selection');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Debugging Selection Issues'),
      noteBox(
          'When selection doesn\'t work as expected, these techniques '
          'help diagnose the problem.'),
      infoCard(
          'Debug Techniques',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Print selection.current', 'Check what\'s selected'),
              dataRow('Print candidates.length', 'How many hit results'),
              dataRow('Print bounds', 'Is bounding box reasonable'),
              dataRow('Print transform', 'Check matrix values'),
              dataRow('debugDumpRenderTree', 'Full render tree dump'),
            ],
          )),
      infoCard(
          'Common Problems',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('No selection', 'Hit test returns empty'),
              dataRow('Wrong widget', 'GestureDetector in front'),
              dataRow('Highlight offset', 'Transform not applied'),
              dataRow('Stale selection', 'Widget rebuilt, ref outdated'),
            ],
          )),
    ],
  );

  // ─── Section 15: Performance ───
  print('[Section 15] Performance');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Performance Considerations'),
      noteBox(
          'Inspector selection is debug-only but should still be performant '
          'to avoid degrading the developer experience.'),
      infoCard(
          'Performance Factors',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Hit test cost', 'O(depth) per tap'),
              dataRow('Transform', 'Cached per frame'),
              dataRow('Overlay paint', 'Single rect, minimal cost'),
              dataRow('Candidate list', 'Typically 5-15 entries'),
              dataRow('Memory', 'Single RenderObject reference'),
            ],
          )),
    ],
  );

  // ─── Section 16: Visual Dashboard ───
  print('[Section 16] Visual Dashboard');

  final section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('16', 'Visual Dashboard'),
      noteBox('Complete overview of the InspectorSelection deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Teal', teal),
              colorSwatch('Cyan', cyan),
              colorSwatch('Deep Teal', deepTeal),
              colorSwatch('Pale Aqua', paleAqua),
              colorSwatch('Turquoise', turquoise),
              colorSwatch('Seafoam', seafoam),
              colorSwatch('Ocean', ocean),
              colorSwatch('Lagoon', lagoon),
              colorSwatch('Malachite', malachite),
              colorSwatch('Jade', jade),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, teal),
              progressBar('Selection Model', 1.0, cyan),
              progressBar('Current vs Candidates', 1.0, ocean),
              progressBar('Hit Testing', 1.0, jade),
              progressBar('Bounding Box', 1.0, teal),
              progressBar('Highlight Painting', 1.0, cyan),
              progressBar('Transform Matrix', 1.0, ocean),
              progressBar('Selection Events', 1.0, jade),
              progressBar('Overlay Integration', 1.0, teal),
              progressBar('Programmatic Selection', 1.0, cyan),
              progressBar('Selection Clearing', 1.0, ocean),
              progressBar('Multi-candidate Cycling', 1.0, jade),
              progressBar('Edge Cases', 1.0, teal),
              progressBar('Debugging', 1.0, cyan),
              progressBar('Performance', 1.0, ocean),
              progressBar('Dashboard', 1.0, jade),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Teal / Cyan'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('InspectorSelection', teal, Colors.white),
          tag('Hit Testing', cyan, Colors.white),
          tag('Bounding Box', ocean, Colors.white),
          tag('Transform Matrix', jade, Colors.white),
          tag('Overlay Painting', turquoise, deepTeal),
          tag('Candidate Cycling', lagoon, deepTeal),
        ],
      ),
    ],
  );

  print('===== END INSPECTOR SELECTION DEEP DEMO =====');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        section1,
        section2,
        section3,
        section4,
        section5,
        section6,
        section7,
        section8,
        section9,
        section10,
        section11,
        section12,
        section13,
        section14,
        section15,
        section16,
      ],
    ),
  );
}
