// ignore_for_file: avoid_print
// D4rt deep demo: DialogWindowControllerDelegate — a delegate interface for
// controlling dialog windows in multi-window desktop Flutter applications.
// This covers dialog lifecycle, window configuration, dismissal strategy,
// and the relationship between dialog and parent window controllers.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Olive / Sage palette ───
  const Color olive = Color(0xFF6B7F3B);
  const Color sage = Color(0xFF9CAF88);
  const Color deepOlive = Color(0xFF4A5A28);
  const Color paleMoss = Color(0xFFF5F7F0);
  const Color fern = Color(0xFF5D7A35);
  const Color mint = Color(0xFFDDE8D0);
  const Color forest = Color(0xFF2D3E1F);
  const Color lichen = Color(0xFFB3C4A0);
  const Color willow = Color(0xFF8FAF6E);
  const Color moss = Color(0xFF7A9B5B);

  print('===== DIALOG WINDOW CONTROLLER DELEGATE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [forest, deepOlive],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: forest.withValues(alpha: 0.35),
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
              color: olive,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: willow, width: 1.5),
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
        color: paleMoss,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: mint),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepOlive.withValues(alpha: 0.9),
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
        border: Border.all(color: mint),
        boxShadow: [
          BoxShadow(
            color: olive.withValues(alpha: 0.07),
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
              color: paleMoss,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: forest)),
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
                    color: forest)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: deepOlive)),
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
                  color: forest.withValues(alpha: 0.15), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: forest),
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
              Text(label,
                  style: TextStyle(fontSize: 11, color: forest)),
              Text('${(fraction * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: color)),
            ],
          ),
          const SizedBox(height: 3),
          Container(
            width: double.infinity,
            height: 7,
            decoration: BoxDecoration(
              color: lichen.withValues(alpha: 0.3),
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

  Widget windowFrame(String title, Color borderColor, bool focused, Widget child) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: focused ? 2 : 1),
        boxShadow: focused
            ? [BoxShadow(color: borderColor.withValues(alpha: 0.2), blurRadius: 8, offset: const Offset(0, 4))]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            decoration: BoxDecoration(
              color: focused ? borderColor.withValues(alpha: 0.15) : paleMoss,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10, height: 10,
                  decoration: BoxDecoration(
                    color: focused ? borderColor : lichen,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                const SizedBox(width: 8),
                Text(title,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: focused ? FontWeight.w700 : FontWeight.normal,
                        color: focused ? borderColor : deepOlive)),
              ],
            ),
          ),
          Padding(padding: const EdgeInsets.all(10), child: child),
        ],
      ),
    );
  }

  Widget lifecycleStep(String step, String description, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 22, height: 22,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(step,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(description,
                style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Overview ───
  print('[Section 1] Overview');

  final section1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('01', 'Overview & Purpose'),
      noteBox(
          'DialogWindowControllerDelegate defines the interface for objects '
          'that manage dialog window behavior in multi-window desktop Flutter '
          'applications. It enables custom control over dialog presentation, '
          'dismissal, and interaction with the parent window.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Abstract interface / delegate protocol'),
              dataRow('Package', 'flutter/widgets'),
              dataRow('Platform scope', 'Desktop (macOS, Windows, Linux)'),
              dataRow('Purpose', 'Dialog window lifecycle control'),
              dataRow('Pattern', 'Delegate (delegation pattern)'),
            ],
          )),
      infoCard(
          'Why It Exists',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Multi-window', 'Desktop apps can have many windows'),
              dataRow('Dialogs ≠ overlays', 'Real OS dialog windows'),
              dataRow('Custom behavior', 'Dismiss, resize, style per-dialog'),
              dataRow('Parent control', 'Parent window manages its dialogs'),
            ],
          )),
    ],
  );

  // ─── Section 2: Desktop Window Model ───
  print('[Section 2] Desktop Window Model');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Desktop Window Model'),
      noteBox(
          'Unlike mobile, desktop Flutter apps can create multiple OS-level '
          'windows. Dialogs on desktop may be separate OS windows rather than '
          'overlay routes, requiring dedicated lifecycle management.'),
      infoCard(
          'Mobile vs Desktop Dialogs',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mobile dialog', 'Overlay route within single window'),
              dataRow('Desktop dialog', 'Can be a separate OS window'),
              dataRow('Mobile dismiss', 'Navigator.pop or barrier tap'),
              dataRow('Desktop dismiss', 'Window close button, Escape, API'),
              dataRow('Mobile parent', 'Same window (overlay stack)'),
              dataRow('Desktop parent', 'Separate window with ownership'),
            ],
          )),
      infoCard(
          'Window Hierarchy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              windowFrame('Main Window (Parent)', olive, true,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Application content',
                          style: TextStyle(fontSize: 11, color: deepOlive)),
                      const SizedBox(height: 6),
                      windowFrame('Dialog Window (Child)', fern, false,
                          Text('Dialog content — separate OS window',
                              style: TextStyle(fontSize: 11, color: deepOlive))),
                    ],
                  )),
            ],
          )),
    ],
  );

  // ─── Section 3: Delegate Protocol ───
  print('[Section 3] Delegate Protocol');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Delegate Protocol'),
      noteBox(
          'The delegate protocol defines callbacks that the dialog window '
          'controller invokes at key points in the dialog\'s lifecycle. '
          'Implementing these gives the parent full control.'),
      infoCard(
          'Delegate Methods',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('windowShouldClose', 'Can the dialog close now?'),
              dataRow('windowWillClose', 'Dialog is about to close'),
              dataRow('windowDidClose', 'Dialog has fully closed'),
              dataRow('windowDidResize', 'Dialog was resized'),
              dataRow('windowDidBecomeKey', 'Dialog became focused window'),
              dataRow('windowDidResignKey', 'Dialog lost focus'),
            ],
          )),
      infoCard(
          'Delegation Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Controller owns', 'Dialog window lifecycle'),
              dataRow('Delegate advises', 'How to handle events'),
              dataRow('Controller calls', 'Delegate at decision points'),
              dataRow('Delegate returns', 'Approval or guidance'),
            ],
          )),
    ],
  );

  // ─── Section 4: Window Lifecycle ───
  print('[Section 4] Window Lifecycle');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Window Lifecycle'),
      noteBox(
          'A dialog window goes through distinct lifecycle phases. The '
          'delegate can influence each phase, from creation through '
          'presentation to eventual dismissal.'),
      infoCard(
          'Lifecycle Phases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lifecycleStep('1', 'Requested — Parent asks for a dialog', olive),
              lifecycleStep('2', 'Created — OS window allocated', fern),
              lifecycleStep('3', 'Configured — Size, position, style set', moss),
              lifecycleStep('4', 'Presented — Dialog visible on screen', willow),
              lifecycleStep('5', 'Active — User interacting with dialog', sage),
              lifecycleStep('6', 'Closing — windowShouldClose queried', olive),
              lifecycleStep('7', 'Closed — windowDidClose invoked', forest),
            ],
          )),
      infoCard(
          'Phase Timing',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Created → Presented', 'Near-instant, single frame'),
              dataRow('Active duration', 'User-driven, indeterminate'),
              dataRow('Closing → Closed', 'Synchronous if no veto'),
              dataRow('With veto', 'Close deferred or cancelled'),
            ],
          )),
    ],
  );

  // ─── Section 5: Window Configuration ───
  print('[Section 5] Window Configuration');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Window Configuration'),
      noteBox(
          'Dialog windows support rich configuration — size, position, '
          'modality, title bar style, and resize behavior — all influenced '
          'by the delegate or initial parameters.'),
      infoCard(
          'Size & Position',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Initial size', 'Set at creation time'),
              dataRow('Min / max size', 'Constrain resize range'),
              dataRow('Position', 'Center on parent, or explicit offset'),
              dataRow('Relative', 'Can anchor to parent window edges'),
            ],
          )),
      infoCard(
          'Window Style',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Title bar', 'Visible, hidden, or custom'),
              dataRow('Resizable', 'bool — whether user can resize'),
              dataRow('Closable', 'Whether close button appears'),
              dataRow('Minimizable', 'Whether minimize button appears'),
              dataRow('Shadow', 'OS window shadow enabled'),
            ],
          )),
      infoCard(
          'Modality',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Modal', 'Blocks parent until dismissed'),
              dataRow('Non-modal', 'Exists alongside parent'),
              dataRow('Sheet', 'Attached to parent (macOS)'),
              dataRow('Application modal', 'Blocks entire app'),
            ],
          )),
    ],
  );

  // ─── Section 6: Dismissal Strategies ───
  print('[Section 6] Dismissal Strategies');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'Dismissal Strategies'),
      noteBox(
          'The delegate controls how and when a dialog can be dismissed. '
          'This is critical for confirmation dialogs, unsaved-changes '
          'guards, and multi-step wizards.'),
      infoCard(
          'Dismiss Sources',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Close button', 'Window title bar X button'),
              dataRow('Escape key', 'Keyboard shortcut'),
              dataRow('Programmatic', 'Controller.close() call'),
              dataRow('Parent close', 'Cascade from parent window'),
              dataRow('OS force quit', 'Cannot be vetoed'),
            ],
          )),
      infoCard(
          'Veto Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('windowShouldClose', 'Return false to prevent close'),
              dataRow('Use case', 'Unsaved changes confirmation'),
              dataRow('Show sub-dialog', 'Ask "Save?" before allowing close'),
              dataRow('Conditional veto', 'Close only if form is valid'),
            ],
          )),
      infoCard(
          'Cascade Dismissal',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Parent closes', 'All child dialogs notified'),
              dataRow('Order', 'Children close first, then parent'),
              dataRow('Veto in cascade', 'Child can delay parent close'),
              dataRow('Force close', 'Overrides all vetos'),
            ],
          )),
    ],
  );

  // ─── Section 7: Parent/Child Relationship ───
  print('[Section 7] Parent/Child Relationship');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Parent / Child Relationship'),
      noteBox(
          'Dialog windows maintain a parent-child relationship with the '
          'window that spawned them. This affects focus, z-order, and '
          'lifecycle cascading.'),
      infoCard(
          'Ownership Rules',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Parent owns', 'Dialog window reference'),
              dataRow('Child references', 'Parent for relative positioning'),
              dataRow('Focus return', 'When dialog closes → parent refocused'),
              dataRow('Z-order', 'Dialog stays above parent'),
            ],
          )),
      infoCard(
          'Visual Relationship',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              windowFrame('Main Application Window', olive, false,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Content dimmed while dialog is modal',
                          style: TextStyle(fontSize: 11, color: deepOlive.withValues(alpha: 0.6))),
                    ],
                  )),
              windowFrame('Settings Dialog', fern, true,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Active — receives all input',
                          style: TextStyle(fontSize: 11, color: deepOlive)),
                      const SizedBox(height: 4),
                      windowFrame('Confirm Sub-Dialog', moss, true,
                          Text('Nested dialog — blocks Settings',
                              style: TextStyle(fontSize: 11, color: deepOlive))),
                    ],
                  )),
            ],
          )),
    ],
  );

  // ─── Section 8: Focus Management ───
  print('[Section 8] Focus Management');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Focus Management'),
      noteBox(
          'The delegate receives notifications about focus changes. Knowing '
          'when a dialog gains or loses focus is essential for implementing '
          'keyboard shortcuts, visual feedback, and state transitions.'),
      infoCard(
          'Focus Events',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('windowDidBecomeKey', 'Dialog gains keyboard focus'),
              dataRow('windowDidResignKey', 'Dialog loses keyboard focus'),
              dataRow('Key window', 'OS term — receives keyboard input'),
              dataRow('Main window', 'OS term — menu bar target'),
            ],
          )),
      infoCard(
          'Focus Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lifecycleStep('1', 'Dialog presented → becomes key window', olive),
              lifecycleStep('2', 'Parent resigns key status', fern),
              lifecycleStep('3', 'User clicks parent → dialog resignsKey', moss),
              lifecycleStep('4', 'Modal dialog: focus trapped in dialog', willow),
            ],
          )),
    ],
  );

  // ─── Section 9: Platform Integration ───
  print('[Section 9] Platform Integration');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Platform Integration'),
      noteBox(
          'Each desktop OS handles dialog windows differently. The delegate '
          'pattern abstracts these differences while still exposing '
          'platform-specific capabilities.'),
      infoCard(
          'macOS',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('NSWindow', 'Underlying native window'),
              dataRow('Sheets', 'Slide down from parent title bar'),
              dataRow('NSWindowDelegate', 'Native analog'),
              dataRow('Close behavior', 'Red traffic light button'),
            ],
          )),
      infoCard(
          'Windows',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('HWND', 'Win32 window handle'),
              dataRow('Modal dialogs', 'DialogBox / DialogBoxIndirect'),
              dataRow('WM_CLOSE', 'Window close message'),
              dataRow('Owner window', 'Parent-child via owner'),
            ],
          )),
      infoCard(
          'Linux',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('GtkWindow', 'GTK dialog window'),
              dataRow('Transient for', 'Parent relationship hint'),
              dataRow('destroy signal', 'Close notification'),
              dataRow('Window manager', 'Varies by desktop environment'),
            ],
          )),
    ],
  );

  // ─── Section 10: Common Dialog Types ───
  print('[Section 10] Common Dialog Types');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Common Dialog Types'),
      noteBox(
          'Different dialog types require different delegate behavior. '
          'A save confirmation needs veto support, while an about dialog '
          'just needs simple close handling.'),
      infoCard(
          'Confirmation Dialog',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Verify destructive action'),
              dataRow('Modal', 'Yes — blocks parent'),
              dataRow('Dismiss', 'OK / Cancel buttons'),
              dataRow('Veto close?', 'No — simple accept/reject'),
            ],
          )),
      infoCard(
          'Form / Settings Dialog',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Edit configuration'),
              dataRow('Modal', 'Often non-modal'),
              dataRow('Dismiss', 'Save + close, Cancel'),
              dataRow('Veto close?', 'Yes — unsaved changes guard'),
            ],
          )),
      infoCard(
          'Wizard Dialog',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Multi-step process'),
              dataRow('Modal', 'Yes — guided flow'),
              dataRow('Dismiss', 'Cancel warns about lost progress'),
              dataRow('Veto close?', 'Yes — incomplete steps warning'),
            ],
          )),
      infoCard(
          'Inspector / Panel',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Purpose', 'Floating tool window'),
              dataRow('Modal', 'No — non-blocking'),
              dataRow('Dismiss', 'Close freely'),
              dataRow('Veto close?', 'No'),
            ],
          )),
    ],
  );

  // ─── Section 11: Resize Handling ───
  print('[Section 11] Resize Handling');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Resize Handling'),
      noteBox(
          'The windowDidResize callback informs the delegate when a dialog '
          'window is resized. This enables responsive layout adjustments '
          'and enforcing size constraints.'),
      infoCard(
          'Resize Events',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Source', 'User drags window edge'),
              dataRow('Callback', 'windowDidResize(newSize)'),
              dataRow('Constraints', 'Min/max enforced by OS'),
              dataRow('Aspect ratio', 'Optional lock via delegate'),
            ],
          )),
      infoCard(
          'Responsive Dialog',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Small (<400px)', 'Single-column layout'),
              dataRow('Medium (400-700px)', 'Two-column layout'),
              dataRow('Large (>700px)', 'Full layout with sidebar'),
              dataRow('Delegate role', 'Notify content to reflow'),
            ],
          )),
    ],
  );

  // ─── Section 12: Dialog Communication ───
  print('[Section 12] Dialog Communication');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Dialog Communication'),
      noteBox(
          'Dialogs need to communicate results back to the parent. The '
          'delegate pattern facilitates this through close callbacks, '
          'return values, and shared state.'),
      infoCard(
          'Communication Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Callback closure', 'Pass Function to dialog'),
              dataRow('Return value', 'Dialog resolves Future<T>'),
              dataRow('Shared state', 'Both windows access same model'),
              dataRow('Event bus', 'Cross-window event distribution'),
            ],
          )),
      infoCard(
          'Result Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Confirmed', 'User accepted (OK/Save/Yes)'),
              dataRow('Cancelled', 'User dismissed (Cancel/X/Escape)'),
              dataRow('Data', 'User entered/selected values'),
              dataRow('No result', 'Info dialog — just acknowledged'),
            ],
          )),
    ],
  );

  // ─── Section 13: Error Handling ───
  print('[Section 13] Error Handling');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Error Handling'),
      noteBox(
          'Dialog operations can fail — window creation may be rejected by '
          'the OS, close may be vetoed unexpectedly, or the parent may '
          'dispose before the dialog closes.'),
      infoCard(
          'Failure Modes',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Creation failed', 'OS refused window allocation'),
              dataRow('Parent disposed', 'Orphaned dialog window'),
              dataRow('Focus deadlock', 'Modal dialog behind parent'),
              dataRow('Infinite veto', 'windowShouldClose always false'),
            ],
          )),
      infoCard(
          'Defensive Patterns',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Null-check parent', 'Before referencing parent window'),
              dataRow('Timeout veto', 'Force close after N seconds'),
              dataRow('Orphan cleanup', 'Close dialogs on parent dispose'),
              dataRow('Focus recovery', 'Bring dialog to front if stuck'),
            ],
          )),
    ],
  );

  // ─── Section 14: Testing ───
  print('[Section 14] Testing');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Testing'),
      noteBox(
          'Testing dialog delegates requires simulating window events — '
          'close requests, focus changes, and resize. Flutter\'s test '
          'infrastructure provides hooks to simulate these.'),
      infoCard(
          'What to Test',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Veto logic', 'windowShouldClose returns correctly'),
              dataRow('Cleanup', 'windowDidClose releases resources'),
              dataRow('Focus handling', 'State updates on focus change'),
              dataRow('Resize', 'Layout adapts to new size'),
            ],
          )),
      infoCard(
          'Mock Approaches',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mock controller', 'Simulate window events'),
              dataRow('Fake delegate', 'Record method calls'),
              dataRow('Integration', 'Real window on CI (desktop)'),
              dataRow('Golden tests', 'Snapshot dialog layout'),
            ],
          )),
    ],
  );

  // ─── Section 15: Comparison with showDialog ───
  print('[Section 15] Comparison with showDialog');

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Comparison with showDialog'),
      noteBox(
          'showDialog() creates an overlay route, not a real OS window. '
          'DialogWindowControllerDelegate manages actual OS windows — a '
          'fundamentally different approach.'),
      infoCard(
          'showDialog vs Controller Delegate',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('showDialog', 'Overlay route in same window'),
              dataRow('Controller delegate', 'Separate OS window'),
              dataRow('showDialog scope', 'All platforms'),
              dataRow('Delegate scope', 'Desktop only'),
              dataRow('showDialog modality', 'Route-based barrier'),
              dataRow('Delegate modality', 'OS-level window modal'),
              dataRow('showDialog dismiss', 'Navigator.pop()'),
              dataRow('Delegate dismiss', 'controller.close()'),
            ],
          )),
      infoCard(
          'When to Use Which',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mobile + web app', 'Always showDialog'),
              dataRow('Desktop — simple alert', 'showDialog is fine'),
              dataRow('Desktop — settings panel', 'Controller delegate'),
              dataRow('Desktop — inspector tool', 'Controller delegate'),
              dataRow('Multi-window needed', 'Controller delegate'),
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
      noteBox('Complete overview of the DialogWindowControllerDelegate deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Olive', olive),
              colorSwatch('Sage', sage),
              colorSwatch('Deep Olive', deepOlive),
              colorSwatch('Pale Moss', paleMoss),
              colorSwatch('Fern', fern),
              colorSwatch('Mint', mint),
              colorSwatch('Forest', forest),
              colorSwatch('Lichen', lichen),
              colorSwatch('Willow', willow),
              colorSwatch('Moss', moss),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, olive),
              progressBar('Desktop Window Model', 1.0, fern),
              progressBar('Delegate Protocol', 1.0, moss),
              progressBar('Window Lifecycle', 1.0, willow),
              progressBar('Configuration', 1.0, olive),
              progressBar('Dismissal Strategies', 1.0, fern),
              progressBar('Parent/Child', 1.0, moss),
              progressBar('Focus Management', 1.0, willow),
              progressBar('Platform Integration', 1.0, olive),
              progressBar('Common Dialogs', 1.0, fern),
              progressBar('Resize Handling', 1.0, moss),
              progressBar('Communication', 1.0, willow),
              progressBar('Error Handling', 1.0, olive),
              progressBar('Testing', 1.0, fern),
              progressBar('vs showDialog', 1.0, moss),
              progressBar('Dashboard', 1.0, willow),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Olive / Sage'),
              dataRow('Palette colors', '10'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('DialogController', olive, Colors.white),
          tag('Desktop Windows', fern, Colors.white),
          tag('Delegate Pattern', moss, Colors.white),
          tag('Multi-Window', willow, forest),
          tag('Window Lifecycle', sage, forest),
          tag('Focus Management', forest, Colors.white),
        ],
      ),
    ],
  );

  print('===== END DIALOG WINDOW CONTROLLER DELEGATE DEEP DEMO =====');

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
