// ignore_for_file: avoid_print
// D4rt deep demo: MouseCursorManager — resolves and manages which mouse
// cursor is displayed based on hit-test annotations in the render tree.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Slate / Silver palette ───
  const Color slate = Color(0xFF546E7A);
  const Color silver = Color(0xFFB0BEC5);
  const Color deepSlate = Color(0xFF37474F);
  const Color paleSlate = Color(0xFFECEFF1);
  const Color charcoal = Color(0xFF263238);
  const Color pewter = Color(0xFF78909C);
  const Color ash = Color(0xFF90A4AE);
  const Color graphite = Color(0xFF455A64);
  const Color fog = Color(0xFFF5F7F8);
  const Color steel = Color(0xFF607D8B);

  print('[mc] ===== MOUSE CURSOR MANAGER DEEP DEMO =====');

  // ─── Local helpers ───

  Widget mcBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [charcoal, deepSlate],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: charcoal.withValues(alpha: 0.35),
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
              color: slate,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: silver, width: 1.5),
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

  Widget mcNote(String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paleSlate,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: silver),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: charcoal.withValues(alpha: 0.9),
              height: 1.5)),
    );
  }

  Widget mcCard(String heading, Widget content) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: silver.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: charcoal.withValues(alpha: 0.06),
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: slate.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: charcoal)),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: content,
          ),
        ],
      ),
    );
  }

  Widget mcRow(List<String> cells, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 4),
      decoration: BoxDecoration(
        color: isHeader ? slate.withValues(alpha: 0.06) : Colors.transparent,
        border: Border(
          bottom: BorderSide(color: silver.withValues(alpha: 0.3)),
        ),
      ),
      child: Row(
        children: cells.map((c) {
          return Expanded(
            child: Text(c,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                    color: isHeader ? charcoal : graphite)),
          );
        }).toList(),
      ),
    );
  }

  Widget mcFlow(List<String> steps) {
    List<Widget> items = [];
    for (int i = 0; i < steps.length; i++) {
      items.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: (i % 2 == 0) ? charcoal : deepSlate,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(steps[i],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w600)),
        ),
      );
      if (i < steps.length - 1) {
        items.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(Icons.arrow_forward, size: 12, color: slate),
        ));
      }
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: items),
    );
  }

  // ━━━━━━ SECTION 1: What is MouseCursorManager? ━━━━━━
  print('[mc-01] Section 1: What is MouseCursorManager?');

  Widget section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('01', 'What Is MouseCursorManager?'),
      mcNote(
        'MouseCursorManager is the engine that resolves which mouse cursor '
        'to display at any given position. As the mouse moves, the framework '
        'hit-tests the render tree, collects MouseCursor annotations from '
        'MouseRegion widgets, and the manager decides the final cursor '
        'by choosing the front-most annotation.',
      ),
      mcCard(
        'Resolution Pipeline',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mcFlow(['Mouse move', 'Hit test', 'Collect annotations',
                'Resolve cursor', 'Set platform cursor']),
            const SizedBox(height: 10),
            _mcRoleBadge('Collects', 'MouseCursor annotations from hit test', slate),
            _mcRoleBadge('Resolves', 'Front-most annotation wins', pewter),
            _mcRoleBadge('Defers', 'defer() falls through to next', graphite),
            _mcRoleBadge('Applies', 'Sends to platform via channel', deepSlate),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 2: MouseCursor types ━━━━━━
  print('[mc-02] Section 2: MouseCursor types');

  Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('02', 'MouseCursor Class Hierarchy'),
      mcNote(
        'MouseCursor is abstract. SystemMouseCursors provides platform-native '
        'cursors. MaterialStateMouseCursor adapts the cursor based on '
        'material states (hovered, focused, disabled). Custom cursors '
        'can be created by extending MouseCursor.',
      ),
      mcCard(
        'Class Hierarchy',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mcClassBox('MouseCursor', 'Abstract base class', charcoal, 0),
            _mcClassBox('SystemMouseCursor', 'Platform-native cursors', deepSlate, 1),
            _mcClassBox('MaterialStateMouseCursor', 'State-dependent cursors', slate, 1),
            _mcClassBox('_DeferringMouseCursor', 'Falls through to parent', pewter, 1),
            _mcClassBox('_NoopMouseCursor', 'Invisible, no change', ash, 1),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 3: SystemMouseCursors catalog ━━━━━━
  print('[mc-03] Section 3: SystemMouseCursors');

  Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('03', 'SystemMouseCursors Catalog'),
      mcNote(
        'SystemMouseCursors provides a comprehensive catalog of platform-'
        'native mouse cursors. Each cursor maps to the operating system\'s '
        'native cursor type. Appearance may differ between platforms but '
        'semantics are consistent.',
      ),
      mcCard(
        'Cursor Catalog — Navigation',
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _mcCursorChip('basic', Icons.mouse, charcoal),
            _mcCursorChip('click', Icons.touch_app, deepSlate),
            _mcCursorChip('forbidden', Icons.block, slate),
            _mcCursorChip('wait', Icons.hourglass_top, pewter),
            _mcCursorChip('progress', Icons.pending, graphite),
            _mcCursorChip('contextMenu', Icons.menu, ash),
            _mcCursorChip('help', Icons.help, steel),
            _mcCursorChip('none', Icons.visibility_off, charcoal),
          ],
        ),
      ),
      mcCard(
        'Cursor Catalog — Editing',
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _mcCursorChip('text', Icons.text_fields, charcoal),
            _mcCursorChip('verticalText', Icons.text_rotation_none, deepSlate),
            _mcCursorChip('cell', Icons.grid_on, slate),
            _mcCursorChip('precise', Icons.add, pewter),
            _mcCursorChip('copy', Icons.content_copy, graphite),
            _mcCursorChip('alias', Icons.shortcut, steel),
            _mcCursorChip('noDrop', Icons.do_not_disturb, ash),
            _mcCursorChip('grab', Icons.pan_tool, charcoal),
            _mcCursorChip('grabbing', Icons.pan_tool_alt, deepSlate),
          ],
        ),
      ),
      mcCard(
        'Cursor Catalog — Resize',
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            _mcCursorChip('resizeColumn', Icons.swap_horiz, charcoal),
            _mcCursorChip('resizeRow', Icons.swap_vert, deepSlate),
            _mcCursorChip('resizeUp', Icons.north, slate),
            _mcCursorChip('resizeDown', Icons.south, pewter),
            _mcCursorChip('resizeLeft', Icons.west, graphite),
            _mcCursorChip('resizeRight', Icons.east, steel),
            _mcCursorChip('resizeUpDown', Icons.unfold_more, ash),
            _mcCursorChip('resizeLeftRight', Icons.unfold_less, charcoal),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 4: Cursor resolution ━━━━━━
  print('[mc-04] Section 4: Cursor resolution');

  Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('04', 'Cursor Resolution Logic'),
      mcNote(
        'When the mouse pointer moves, the framework performs a hit test '
        'through the render tree. Each MouseRegion adds a MouseCursor '
        'annotation. The manager walks annotations front-to-back. If a '
        'cursor is defer(), it skips to the next. The first non-defer '
        'cursor wins.',
      ),
      mcCard(
        'Resolution Walk',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: fog,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              _mcResolutionStep(1, 'Front-most annotation', 'MouseCursor.defer', 'Skip', charcoal),
              _mcResolutionStep(2, 'Next annotation', 'SystemMouseCursors.click', 'Use!', deepSlate),
              _mcResolutionStep(3, 'Would check next', '(not reached)', '—', ash),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: paleSlate,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Result: SystemMouseCursors.click — because defer() '
                  'on the overlay let the button underneath decide.',
                  style: TextStyle(fontSize: 10, color: charcoal),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 5: MouseRegion widget ━━━━━━
  print('[mc-05] Section 5: MouseRegion widget');

  Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('05', 'MouseRegion Widget'),
      mcNote(
        'MouseRegion is the main widget for specifying mouse cursors. '
        'Set the cursor property to change the cursor when the mouse '
        'enters the region. MouseRegion also provides onEnter, onHover, '
        'and onExit callbacks for mouse tracking.',
      ),
      mcCard(
        'MouseRegion Properties',
        Column(
          children: [
            mcRow(['Property', 'Type', 'Purpose'], isHeader: true),
            mcRow(['cursor', 'MouseCursor', 'Cursor when hovering']),
            mcRow(['onEnter', 'PointerEnterCallback?', 'Mouse entered region']),
            mcRow(['onHover', 'PointerHoverCallback?', 'Mouse moved within']),
            mcRow(['onExit', 'PointerExitCallback?', 'Mouse left region']),
            mcRow(['opaque', 'bool', 'Whether hit test is opaque']),
            mcRow(['hitTestBehavior', 'HitTestBehavior', 'How to participate']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 6: Cursor stacking ━━━━━━
  print('[mc-06] Section 6: Cursor stacking');

  Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('06', 'Cursor Stacking and Priority'),
      mcNote(
        'When multiple MouseRegion widgets overlap, the front-most wins. '
        'An overlay with defer() allows the cursor underneath to show. '
        'This is common: a tooltip layer uses defer() so the button '
        'cursor beneath it is used.',
      ),
      mcCard(
        'Stacking Example',
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: fog,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              _mcStackLevel('Tooltip overlay', 'defer()', 'Passes through', ash, 3),
              _mcStackLevel('Button', 'click', 'Wins!', deepSlate, 2),
              _mcStackLevel('Background', 'basic', 'Fallback', paleSlate, 1),
            ],
          ),
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 7: MaterialStateMouseCursor ━━━━━━
  print('[mc-07] Section 7: MaterialStateMouseCursor');

  Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('07', 'MaterialStateMouseCursor'),
      mcNote(
        'MaterialStateMouseCursor adapts the cursor based on MaterialState. '
        'Flutter\'s built-in instance clickable returns click for enabled '
        'widgets and basic for disabled ones. Custom variants can respond '
        'to hovered, focused, pressed, etc.',
      ),
      mcCard(
        'State-Dependent Cursors',
        Column(
          children: [
            mcRow(['State', 'clickable Cursor', 'textable Cursor'], isHeader: true),
            mcRow(['enabled', 'click', 'text']),
            mcRow(['disabled', 'basic', 'basic']),
            mcRow(['hovered', 'click', 'text']),
            mcRow(['focused', 'click', 'text']),
            mcRow(['pressed', 'click', 'text']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 8: Custom cursors ━━━━━━
  print('[mc-08] Section 8: Custom cursors');

  Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('08', 'Custom Cursors'),
      mcNote(
        'To create a custom cursor, extend MouseCursor and override '
        'createSession(). The session activates and deactivates the '
        'cursor as the mouse enters and leaves the region. On the web, '
        'CSS cursors (including custom images) can be used.',
      ),
      mcCard(
        'Custom Cursor Steps',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mcStepItem(1, 'Extend MouseCursor', 'class MyCursor extends MouseCursor', charcoal),
            _mcStepItem(2, 'Override createSession()', 'Returns MouseCursorSession', deepSlate),
            _mcStepItem(3, 'Implement activate()', 'Set platform cursor', slate),
            _mcStepItem(4, 'Implement dispose()', 'Restore default', pewter),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 9: Platform cursors ━━━━━━
  print('[mc-09] Section 9: Platform cursors');

  Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('09', 'Platform Cursor Mapping'),
      mcNote(
        'SystemMouseCursors map to native platform cursor names. The '
        'mapping differs per platform. For example, "click" maps to '
        'NSCursor.pointingHandCursor on macOS, Cursor.HAND_CURSOR on Java, '
        'and "pointer" CSS on web.',
      ),
      mcCard(
        'Platform Mapping',
        Column(
          children: [
            mcRow(['Flutter Name', 'macOS', 'Windows', 'Web CSS'], isHeader: true),
            mcRow(['basic', 'arrow', 'IDC_ARROW', 'default']),
            mcRow(['click', 'pointingHand', 'IDC_HAND', 'pointer']),
            mcRow(['text', 'IBeam', 'IDC_IBEAM', 'text']),
            mcRow(['forbidden', 'notAllowed', 'IDC_NO', 'not-allowed']),
            mcRow(['grab', 'openHand', 'IDC_HAND', 'grab']),
            mcRow(['wait', 'busyButClickable', 'IDC_WAIT', 'wait']),
            mcRow(['precise', 'crosshair', 'IDC_CROSS', 'crosshair']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 10: Cursor during drag ━━━━━━
  print('[mc-10] Section 10: Cursor during drag');

  Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('10', 'Cursor During Drag Operations'),
      mcNote(
        'During a drag, the cursor is typically locked to the drag '
        'source\'s cursor (e.g., grab → grabbing). MouseRegion\'s hover '
        'detection is suspended during a drag since the pointer is captured. '
        'The cursor reverts when the drag ends.',
      ),
      mcCard(
        'Drag Cursor Transitions',
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _mcDragPhase('Hovering', 'grab', Icons.pan_tool, slate),
            Icon(Icons.arrow_downward, size: 16, color: slate),
            _mcDragPhase('Dragging', 'grabbing', Icons.pan_tool_alt, deepSlate),
            Icon(Icons.arrow_downward, size: 16, color: slate),
            _mcDragPhase('Dropped', 'basic', Icons.mouse, pewter),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 11: Accessibility ━━━━━━
  print('[mc-11] Section 11: Accessibility');

  Widget section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('11', 'Accessibility and Cursors'),
      mcNote(
        'Cursors provide important visual feedback about interactivity. '
        'The "click" cursor signals clickable elements, "text" signals '
        'editable text, "forbidden" signals disabled areas. Assistive '
        'technologies also use cursor semantics.',
      ),
      mcCard(
        'Cursor Semantics',
        Column(
          children: [
            mcRow(['Cursor', 'Semantic Meaning', 'A11y Role'], isHeader: true),
            mcRow(['click', 'Interactive / clickable', 'button / link']),
            mcRow(['text', 'Text is selectable/editable', 'textbox']),
            mcRow(['forbidden', 'Action not allowed', 'disabled']),
            mcRow(['help', 'Help available', 'tooltip trigger']),
            mcRow(['wait', 'Processing', 'busy state']),
            mcRow(['none', 'Custom handling', 'canvas / game']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 12: Cursor over interactive widgets ━━━━━━
  print('[mc-12] Section 12: Interactive widgets');

  Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('12', 'Cursor in Material Widgets'),
      mcNote(
        'Material widgets set cursors automatically. ElevatedButton uses '
        'click, TextField uses text, disabled widgets use basic. This '
        'is done via MaterialStateMouseCursor.clickable/textable applied '
        'internally by each widget.',
      ),
      mcCard(
        'Widget Cursor Table',
        Column(
          children: [
            mcRow(['Widget', 'Enabled Cursor', 'Disabled Cursor'], isHeader: true),
            mcRow(['ElevatedButton', 'click', 'basic']),
            mcRow(['TextButton', 'click', 'basic']),
            mcRow(['IconButton', 'click', 'basic']),
            mcRow(['TextField', 'text', 'basic']),
            mcRow(['Checkbox', 'click', 'basic']),
            mcRow(['Switch', 'click', 'basic']),
            mcRow(['Slider', 'click', 'basic']),
            mcRow(['InkWell', 'click', 'basic']),
            mcRow(['PopupMenuButton', 'click', 'basic']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 13: Performance ━━━━━━
  print('[mc-13] Section 13: Performance');

  Widget section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('13', 'Performance Considerations'),
      mcNote(
        'The cursor manager only sends a platform channel message when '
        'the resolved cursor actually changes. Moving within the same '
        'MouseRegion doesn\'t trigger new messages. This avoids per-frame '
        'platform calls during smooth mouse movement.',
      ),
      mcCard(
        'Optimization Details',
        Column(
          children: [
            mcRow(['Optimization', 'What', 'Benefit'], isHeader: true),
            mcRow(['Dedup', 'Skip if same cursor', 'No unnecessary calls']),
            mcRow(['Cached session', 'Reuse session object', 'Less GC']),
            mcRow(['Hit test cache', 'Reuse last result', 'Reduce tree walk']),
            mcRow(['Batch changes', 'One call per frame', 'Fewer messages']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 14: Cross-platform behavior ━━━━━━
  print('[mc-14] Section 14: Cross-platform');

  Widget section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('14', 'Cross-Platform Behavior'),
      mcNote(
        'Mouse cursors are relevant on desktop (macOS, Windows, Linux) '
        'and web. On mobile (iOS, Android), cursors are ignored since '
        'there is no mouse pointer. Flutter gracefully skips cursor '
        'resolution on touch-only platforms.',
      ),
      mcCard(
        'Platform Support',
        Column(
          children: [
            mcRow(['Platform', 'Has Cursor?', 'Custom?', 'Full Set?'], isHeader: true),
            mcRow(['macOS', 'Yes', 'Yes', 'Yes']),
            mcRow(['Windows', 'Yes', 'Yes', 'Most']),
            mcRow(['Linux', 'Yes', 'Limited', 'Most']),
            mcRow(['Web', 'Yes', 'CSS cursor', 'Yes']),
            mcRow(['iOS', 'iPadOS only', 'No', 'Some']),
            mcRow(['Android', 'Chrome hover', 'No', 'Limited']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 15: Testing ━━━━━━
  print('[mc-15] Section 15: Testing');

  Widget section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('15', 'Testing Mouse Cursors'),
      mcNote(
        'Test cursor changes with WidgetTester by using TestGesture.moveTo '
        'to position the hover pointer. Check the resolved cursor through '
        'the RendererBinding or by inspecting the MouseRegion\'s cursor '
        'property via finder.widget<MouseRegion>.',
      ),
      mcCard(
        'Test Techniques',
        Column(
          children: [
            mcRow(['Technique', 'What', 'Find'], isHeader: true),
            mcRow(['gesture.moveTo()', 'Hover over widget', 'Triggers cursor']),
            mcRow(['gesture.moveBy()', 'Move relative', 'Transition test']),
            mcRow(['find.byType(MouseRegion)', 'Find region', 'Check cursor prop']),
            mcRow(['RendererBinding', 'Get cursor', 'Active cursor']),
          ],
        ),
      ),
    ],
  );

  // ━━━━━━ SECTION 16: Summary dashboard ━━━━━━
  print('[mc-16] Section 16: Summary dashboard');

  Widget section16 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      mcBanner('16', 'Summary Dashboard'),
      mcCard(
        'MouseCursorManager — Complete',
        Column(
          children: [
            mcRow(['Topic', 'Section', 'Key Insight'], isHeader: true),
            mcRow(['What', 'S01', 'Resolves cursor from hit test']),
            mcRow(['Types', 'S02', 'System, Material, Custom']),
            mcRow(['Catalog', 'S03', '25+ system cursors']),
            mcRow(['Resolution', 'S04', 'Front-most non-defer wins']),
            mcRow(['MouseRegion', 'S05', 'Primary cursor widget']),
            mcRow(['Stacking', 'S06', 'defer() for pass-through']),
            mcRow(['Material', 'S07', 'State-dependent cursors']),
            mcRow(['Custom', 'S08', 'extend MouseCursor']),
            mcRow(['Platform', 'S09', 'Native cursor mapping']),
            mcRow(['Drag', 'S10', 'Locked during drag']),
            mcRow(['A11y', 'S11', 'Cursor = interaction hint']),
            mcRow(['Widgets', 'S12', 'Auto-set in Material']),
            mcRow(['Perf', 'S13', 'Dedup + batch changes']),
            mcRow(['Cross-plat', 'S14', 'Desktop + web only']),
            mcRow(['Testing', 'S15', 'gesture.moveTo + find']),
          ],
        ),
      ),
      mcCard(
        'Slate / Silver Theme',
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _mcColorSwatch('Slate', slate),
            _mcColorSwatch('Silver', silver),
            _mcColorSwatch('Pewter', pewter),
            _mcColorSwatch('Graphite', graphite),
            _mcColorSwatch('Charcoal', charcoal),
          ],
        ),
      ),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [charcoal, deepSlate],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Text('MouseCursorManager — Complete',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(
              'From cursor resolution through system catalogs, stacking, '
              'Material state integration, drag handling, and platform '
              'mapping — the full mouse cursor management story.',
              style: TextStyle(color: silver, fontSize: 12, height: 1.4),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ],
  );

  print('[mc] palette: $ash, $fog, $steel');
  print('[mc] ===== ALL 16 SECTIONS BUILT =====');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text('MouseCursorManager — Cursor Resolution'),
        backgroundColor: charcoal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF7F8F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            section1, section2, section3, section4,
            section5, section6, section7, section8,
            section9, section10, section11, section12,
            section13, section14, section15, section16,
          ],
        ),
      ),
    ),
  );
}

// ═══════════════════════════════════════════════════
// Top-level helpers
// ═══════════════════════════════════════════════════

Widget _mcRoleBadge(String role, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: Text(role,
              style: TextStyle(
                  fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10, color: color.withValues(alpha: 0.8))),
        ),
      ],
    ),
  );
}

Widget _mcClassBox(String name, String desc, Color color, int indent) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 16.0, bottom: 4),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(
        children: [
          if (indent > 0) ...[
            Text('└ ', style: TextStyle(fontSize: 10, color: color)),
          ],
          Expanded(
            child: Text(name,
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.bold,
                    fontFamily: 'monospace', color: color)),
          ),
          Text(desc, style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.6))),
        ],
      ),
    ),
  );
}

Widget _mcCursorChip(String name, IconData icon, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: color),
        const SizedBox(width: 4),
        Text(name,
            style: TextStyle(
                fontSize: 9, fontWeight: FontWeight.w600, color: color)),
      ],
    ),
  );
}

Widget _mcResolutionStep(int num, String layer, String cursor, String result, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(layer,
              style: TextStyle(fontSize: 10, color: color)),
        ),
        Expanded(
          flex: 3,
          child: Text(cursor,
              style: TextStyle(
                  fontSize: 9, fontFamily: 'monospace',
                  color: color.withValues(alpha: 0.7))),
        ),
        SizedBox(
          width: 40,
          child: Text(result,
              style: TextStyle(
                  fontSize: 9, fontWeight: FontWeight.bold, color: color)),
        ),
      ],
    ),
  );
}

Widget _mcStackLevel(String label, String cursor, String note, Color color, int depth) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 4),
    padding: EdgeInsets.only(left: (3 - depth) * 12.0 + 8, top: 6, bottom: 6, right: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Text(label,
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ),
        SizedBox(
          width: 60,
          child: Text(cursor,
              style: TextStyle(fontSize: 9, fontFamily: 'monospace', color: color)),
        ),
        SizedBox(
          width: 70,
          child: Text(note,
              style: TextStyle(fontSize: 9, color: color.withValues(alpha: 0.7))),
        ),
      ],
    ),
  );
}

Widget _mcStepItem(int num, String title, String detail, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Center(
            child: Text('$num',
                style: const TextStyle(
                    color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w600, color: color)),
              Text(detail,
                  style: TextStyle(
                      fontSize: 9, fontFamily: 'monospace',
                      color: color.withValues(alpha: 0.7))),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _mcDragPhase(String phase, String cursor, IconData icon, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(phase,
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.bold, color: color)),
        const Spacer(),
        Text(cursor,
            style: TextStyle(
                fontSize: 10, fontFamily: 'monospace',
                color: color.withValues(alpha: 0.7))),
      ],
    ),
  );
}

Widget _mcColorSwatch(String name, Color color) {
  return Column(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
      const SizedBox(height: 3),
      Text(name, style: const TextStyle(fontSize: 8)),
    ],
  );
}
