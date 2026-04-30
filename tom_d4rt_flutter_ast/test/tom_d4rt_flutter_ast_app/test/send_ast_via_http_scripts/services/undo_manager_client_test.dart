// ignore_for_file: avoid_print
// D4rt deep demo: UndoManagerClient — the mixin that receives undo/redo
// signals from the platform undo manager. Implementers respond to system
// undo/redo events and manage their own state snapshots for reversal.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Burgundy / Wine palette ───
  const Color burgundy = Color(0xFF881337);
  const Color wine = Color(0xFFBE123C);
  const Color deepBurgundy = Color(0xFF4C0519);
  const Color paleRose = Color(0xFFFFF1F2);
  const Color claret = Color(0xFF9F1239);
  const Color blush = Color(0xFFFFE4E6);
  const Color maroon = Color(0xFF6B0F28);
  const Color rosewood = Color(0xFFFB7185);
  const Color plum = Color(0xFFFDA4AF);
  const Color garnet = Color(0xFFE11D48);

  print('===== UNDO MANAGER CLIENT DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepBurgundy, maroon],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepBurgundy.withValues(alpha: 0.35),
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
              color: burgundy,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: rosewood, width: 1.5),
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
        color: paleRose,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: blush),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepBurgundy.withValues(alpha: 0.9),
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
        border: Border.all(color: blush),
        boxShadow: [
          BoxShadow(
            color: burgundy.withValues(alpha: 0.07),
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
              color: paleRose,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepBurgundy)),
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
            width: 150,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepBurgundy)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: maroon)),
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
                  color: deepBurgundy.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepBurgundy),
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
                  style: TextStyle(fontSize: 11, color: deepBurgundy)),
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
              color: plum.withValues(alpha: 0.3),
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

  Widget undoStackEntry(String label, int index, bool isCurrent, Color accent) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: isCurrent ? accent.withValues(alpha: 0.15) : Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
            color: isCurrent ? accent : blush,
            width: isCurrent ? 2 : 1),
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: isCurrent ? accent : plum.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text('$index',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: isCurrent ? Colors.white : deepBurgundy)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: isCurrent ? FontWeight.w700 : FontWeight.normal,
                    color: deepBurgundy)),
          ),
          if (isCurrent)
            Icon(Icons.arrow_back, size: 14, color: accent),
        ],
      ),
    );
  }

  Widget actionButton(String label, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: color)),
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
          'UndoManagerClient is a mixin that enables a class to receive '
          'undo and redo signals from the platform\'s native undo manager. '
          'On iOS/macOS, the system provides a centralized NSUndoManager '
          'that tracks user actions. UndoManagerClient lets Flutter '
          'widgets register as participants in this system, receiving '
          'callbacks when the user invokes undo/redo via system gestures '
          'or keyboard shortcuts.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Mixin'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Receive system undo/redo signals'),
              dataRow('Platform', 'iOS and macOS primarily'),
              dataRow('Implementer', 'EditableTextState'),
            ],
          )),
      infoCard(
          'Why It Exists',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('System integration', 'Participate in OS undo stack'),
              dataRow('Three-finger swipe', 'iOS gesture for undo'),
              dataRow('Shake to undo', 'iOS device shake gesture'),
              dataRow('Cmd+Z / Cmd+Shift+Z', 'macOS keyboard shortcuts'),
            ],
          )),
    ],
  );

  // ─── Section 2: Required Methods ───
  print('[Section 2] Required Methods');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Required Methods'),
      noteBox(
          'Implementing UndoManagerClient requires two key methods and '
          'one property. These define how the client responds to system '
          'undo/redo events and how it connects to the undo manager.'),
      infoCard(
          'handlePlatformUndo()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'handlePlatformUndo(UndoDirection)'),
              dataRow('Called when', 'System triggers undo or redo'),
              dataRow('Parameter', 'UndoDirection.undo or .redo'),
              dataRow('Responsibility', 'Restore/advance state'),
            ],
          )),
      infoCard(
          'undoManager',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Property', 'UndoManager get undoManager'),
              dataRow('Returns', 'The UndoManager this client uses'),
              dataRow('Default', 'UndoManager.client (shared instance)'),
              dataRow('Purpose', 'Connect client to undo system'),
            ],
          )),
      infoCard(
          'UndoDirection Enum',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  actionButton('Undo', Icons.undo, burgundy),
                  actionButton('Redo', Icons.redo, claret),
                ],
              ),
              dataRow('UndoDirection.undo', 'Revert to previous state'),
              dataRow('UndoDirection.redo', 'Advance to next state'),
            ],
          )),
    ],
  );

  // ─── Section 3: Undo Stack Visualization ───
  print('[Section 3] Undo Stack Visualization');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Undo Stack Visualization'),
      noteBox(
          'The undo system works like a stack of state snapshots. Each '
          'user action pushes a new state. Undo pops the stack backward, '
          'redo pushes it forward (if states exist ahead of the cursor).'),
      infoCard(
          'State Stack Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              undoStackEntry('Initial: ""', 0, false, burgundy),
              undoStackEntry('Typed: "Hello"', 1, false, burgundy),
              undoStackEntry('Typed: "Hello World"', 2, true, garnet),
              undoStackEntry('(future: "Hello World!")', 3, false, plum),
              const SizedBox(height: 8),
              dataRow('Current position', 'Index 2'),
              dataRow('Can undo', 'Yes (to index 1)'),
              dataRow('Can redo', 'Yes (to index 3)'),
            ],
          )),
      infoCard(
          'After Undo',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              undoStackEntry('Initial: ""', 0, false, burgundy),
              undoStackEntry('Typed: "Hello"', 1, true, garnet),
              undoStackEntry('Typed: "Hello World"', 2, false, plum),
              undoStackEntry('(future: "Hello World!")', 3, false, plum),
              const SizedBox(height: 8),
              dataRow('Current position', 'Index 1'),
              dataRow('Can undo', 'Yes (to index 0)'),
              dataRow('Can redo', 'Yes (to index 2)'),
            ],
          )),
      infoCard(
          'Branch Discarding',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              noteBox(
                  'If the user undoes to state 1 and then types new text, '
                  'states 2 and 3 are discarded. The new action becomes '
                  'the new head of the stack.'),
              undoStackEntry('Initial: ""', 0, false, burgundy),
              undoStackEntry('Typed: "Hello"', 1, false, burgundy),
              undoStackEntry('Typed: "Hello Flutter"', 2, true, garnet),
              const SizedBox(height: 4),
              dataRow('Discarded', '"Hello World" and "Hello World!"'),
            ],
          )),
    ],
  );

  // ─── Section 4: Platform Integration ───
  print('[Section 4] Platform Integration');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'Platform Integration'),
      noteBox(
          'UndoManagerClient connects to the platform\'s native undo '
          'infrastructure. On iOS, this is NSUndoManager; on macOS, the '
          'same NSUndoManager is exposed through the responder chain.'),
      infoCard(
          'iOS Undo Triggers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  actionButton('3-Finger Swipe Left', Icons.swipe_left, burgundy),
                  actionButton('3-Finger Swipe Right', Icons.swipe_right, claret),
                  actionButton('Shake Device', Icons.vibration, maroon),
                ],
              ),
              dataRow('Swipe left', 'Undo (3 fingers)'),
              dataRow('Swipe right', 'Redo (3 fingers)'),
              dataRow('Shake', 'Shows undo confirmation dialog'),
            ],
          )),
      infoCard(
          'macOS Undo Triggers',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                children: [
                  actionButton('Cmd+Z', Icons.undo, burgundy),
                  actionButton('Cmd+Shift+Z', Icons.redo, claret),
                ],
              ),
              dataRow('Cmd+Z', 'Undo'),
              dataRow('Cmd+Shift+Z', 'Redo'),
              dataRow('Edit menu', 'Undo/Redo menu items'),
            ],
          )),
      infoCard(
          'Platform Message',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Channel', 'flutter/undomanager'),
              dataRow('Method', 'UndoManagerClient.handleUndo'),
              dataRow('Payload', '{"direction": "undo" | "redo"}'),
              dataRow('Response', 'Client processes silently'),
            ],
          )),
    ],
  );

  // ─── Section 5: State Snapshots ───
  print('[Section 5] State Snapshots');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'State Snapshots'),
      noteBox(
          'The client is responsible for maintaining its own undo history. '
          'When the platform says "undo," the client must know what the '
          'previous state was. This typically involves saving immutable '
          'snapshots of the editing state.'),
      infoCard(
          'Snapshot Components',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Text content', 'The full string at that point'),
              dataRow('Selection', 'Cursor position and range'),
              dataRow('Composing', 'Active IME composition range'),
              dataRow('Timestamp', 'When the action occurred'),
            ],
          )),
      infoCard(
          'Snapshot Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Every keystroke', 'Fine-grained but memory heavy'),
              dataRow('Word boundaries', 'Snapshot after each word'),
              dataRow('Time-based', 'Batch changes within 300ms'),
              dataRow('Action-based', 'Snapshot on paste, delete, etc.'),
            ],
          )),
      infoCard(
          'Memory Management',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Stack limit', 'Cap at N undo levels'),
              dataRow('Pruning', 'Drop oldest entries when full'),
              dataRow('Compression', 'Store diffs instead of full state'),
              dataRow('Clear on focus lost', 'Optional: reset on blur'),
            ],
          )),
    ],
  );

  // ─── Section 6: EditableTextState as Client ───
  print('[Section 6] EditableTextState as Client');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'EditableTextState as Client'),
      noteBox(
          'EditableTextState is the primary implementer of '
          'UndoManagerClient in Flutter. It saves TextEditingValue '
          'snapshots and restores them on undo/redo.'),
      infoCard(
          'How EditableTextState Uses It',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mixes in', 'UndoManagerClient'),
              dataRow('Saves snapshot', 'On each significant edit'),
              dataRow('handlePlatformUndo', 'Restores previous value'),
              dataRow('Notifies platform', 'Updates canUndo/canRedo'),
            ],
          )),
      infoCard(
          'Undo in Text Fields',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              undoStackEntry('Empty field', 0, false, burgundy),
              undoStackEntry('"Flutter"', 1, false, burgundy),
              undoStackEntry('"Flutter is"', 2, false, burgundy),
              undoStackEntry('"Flutter is great"', 3, true, garnet),
              const SizedBox(height: 8),
              dataRow('Cmd+Z', 'Restores "Flutter is"'),
              dataRow('Cmd+Z again', 'Restores "Flutter"'),
              dataRow('Cmd+Shift+Z', 'Back to "Flutter is"'),
            ],
          )),
    ],
  );

  // ─── Section 7: Client Registration ───
  print('[Section 7] Client Registration');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Client Registration'),
      noteBox(
          'A client registers itself with the UndoManager when it gains '
          'focus and unregisters when it loses focus. Only one client at '
          'a time typically owns the undo stack.'),
      infoCard(
          'Registration Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Focus gained', 'Client registers with UndoManager'),
              dataRow('Active', 'Platform undo calls → this client'),
              dataRow('Focus lost', 'Client unregisters'),
              dataRow('No client', 'Undo gestures do nothing'),
            ],
          )),
      infoCard(
          'Multiple Clients',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Focus field A', 'A is the active undo client'),
              dataRow('Tab to field B', 'B becomes active, A detaches'),
              dataRow('Undo in B', 'Only B\'s stack is used'),
              dataRow('Tab back to A', 'A re-registers, has its own stack'),
            ],
          )),
    ],
  );

  // ─── Section 8: Undo Grouping ───
  print('[Section 8] Undo Grouping');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'Undo Grouping'),
      noteBox(
          'Undo grouping combines multiple small changes into a single '
          'undoable action. For example, typing "Hello" should be one '
          'undo operation, not five separate character undos.'),
      infoCard(
          'Grouping Strategies',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Time-based', 'Group changes within a time window'),
              dataRow('Delimiter-based', 'New group on space/punctuation'),
              dataRow('Explicit', 'Developer opens/closes groups'),
              dataRow('Action-based', 'New group per paste/delete action'),
            ],
          )),
      infoCard(
          'Typing Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              undoStackEntry('Group 1: "Hello" (5 keystrokes)', 1, false, burgundy),
              undoStackEntry('Group 2: " " (space = new group)', 2, false, burgundy),
              undoStackEntry('Group 3: "World" (5 keystrokes)', 3, true, garnet),
              const SizedBox(height: 8),
              dataRow('One undo', 'Removes "World" (not just "d")'),
              dataRow('Two undos', 'Removes " "'),
              dataRow('Three undos', 'Removes "Hello"'),
            ],
          )),
    ],
  );

  // ─── Section 9: canUndo / canRedo ───
  print('[Section 9] canUndo / canRedo');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'canUndo & canRedo'),
      noteBox(
          'The client must communicate to the platform whether undo and '
          'redo are currently available. This affects the UI of system '
          'undo buttons and the enabled state of menu items.'),
      infoCard(
          'State Transitions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Initial', 'canUndo: false, canRedo: false'),
              dataRow('After typing', 'canUndo: true, canRedo: false'),
              dataRow('After undo', 'canUndo: depends, canRedo: true'),
              dataRow('After redo', 'canUndo: true, canRedo: depends'),
            ],
          )),
      infoCard(
          'Visual State Indicators',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 4),
                      decoration: BoxDecoration(
                        color: burgundy.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: burgundy),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.undo, color: burgundy, size: 24),
                          const SizedBox(height: 4),
                          Text('Undo Available',
                              style: TextStyle(fontSize: 11, color: burgundy)),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        color: plum.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: plum),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.undo, color: plum, size: 24),
                          const SizedBox(height: 4),
                          Text('Undo Disabled',
                              style: TextStyle(fontSize: 11, color: plum)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    ],
  );

  // ─── Section 10: Custom Undo Client ───
  print('[Section 10] Custom Undo Client');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Custom Undo Client'),
      noteBox(
          'Beyond text editing, you can create custom UndoManagerClient '
          'implementations for any undoable operation — drawing apps, '
          'form builders, diagram editors, or any stateful interaction.'),
      infoCard(
          'Drawing App Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              undoStackEntry('Canvas blank', 0, false, burgundy),
              undoStackEntry('Drew red circle', 1, false, burgundy),
              undoStackEntry('Drew blue line', 2, false, burgundy),
              undoStackEntry('Added text label', 3, true, garnet),
              const SizedBox(height: 8),
              dataRow('Undo', 'Remove text label'),
              dataRow('Undo again', 'Remove blue line'),
              dataRow('New draw', 'Discards future states'),
            ],
          )),
      infoCard(
          'Form Builder Example',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              undoStackEntry('Empty form', 0, false, burgundy),
              undoStackEntry('Added name field', 1, false, burgundy),
              undoStackEntry('Added email field', 2, false, burgundy),
              undoStackEntry('Changed name to required', 3, true, garnet),
              const SizedBox(height: 8),
              dataRow('Undo', 'Name back to optional'),
              dataRow('System gesture', 'Same as toolbar undo'),
            ],
          )),
    ],
  );

  // ─── Section 11: Concurrency ───
  print('[Section 11] Concurrency');

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Concurrency & Timing'),
      noteBox(
          'Platform undo events arrive asynchronously through platform '
          'channels. The client must handle these events safely, even if '
          'other state changes are happening simultaneously.'),
      infoCard(
          'Race Conditions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('User types + undo', 'Must not corrupt state'),
              dataRow('IME composing', 'Undo during composition is tricky'),
              dataRow('Async paste', 'Clipboard read + undo overlap'),
              dataRow('Solution', 'Process undo in next microtask'),
            ],
          )),
      infoCard(
          'IME Interaction',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Composing text', 'Not yet committed'),
              dataRow('Undo during compose', 'Cancel composition first'),
              dataRow('After commit', 'Composing becomes undoable'),
              dataRow('Autocorrect', 'Correct + original are undo states'),
            ],
          )),
    ],
  );

  // ─── Section 12: Android Differences ───
  print('[Section 12] Android Differences');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Android Differences'),
      noteBox(
          'Android does not have a system-wide undo manager like iOS/macOS. '
          'On Android, undo/redo is typically handled entirely by the '
          'Flutter framework, not the platform.'),
      infoCard(
          'Platform Comparison',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('iOS/macOS', 'NSUndoManager (system-level)'),
              dataRow('Android', 'No system undo manager'),
              dataRow('Web', 'Browser handles for contentEditable'),
              dataRow('Windows/Linux', 'Framework-managed'),
            ],
          )),
      infoCard(
          'Implications',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('iOS', 'UndoManagerClient receives signals'),
              dataRow('Android', 'Flutter UndoHistory widget handles it'),
              dataRow('Cross-platform', 'Use both approaches'),
              dataRow('UndoHistory', 'Framework-level undo for all platforms'),
            ],
          )),
    ],
  );

  // ─── Section 13: UndoHistory Widget ───
  print('[Section 13] UndoHistory Widget');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'UndoHistory Widget'),
      noteBox(
          'UndoHistory<T> is a framework-level widget that provides undo/redo '
          'functionality without platform dependency. It works on all '
          'platforms and integrates with UndoManagerClient on iOS/macOS.'),
      infoCard(
          'UndoHistory vs UndoManagerClient',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('UndoManagerClient', 'Platform undo signals'),
              dataRow('UndoHistory<T>', 'Framework undo stack'),
              dataRow('Together', 'UndoHistory uses client on iOS'),
              dataRow('Standalone', 'UndoHistory works everywhere'),
            ],
          )),
      infoCard(
          'UndoHistory API',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('value', 'Current state (ValueNotifier)'),
              dataRow('onTriggered', 'Called with restored value'),
              dataRow('focusNode', 'Captures Cmd+Z shortcuts'),
              dataRow('controller', 'UndoHistoryController'),
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
          'Testing UndoManagerClient involves simulating platform undo/redo '
          'messages and verifying the client responds correctly by restoring '
          'the appropriate state.'),
      infoCard(
          'Test Approach',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Mock channel', 'Simulate flutter/undomanager'),
              dataRow('Send undo', 'Dispatch undo direction message'),
              dataRow('Verify state', 'Check textEditingValue reverted'),
              dataRow('Check canUndo', 'Verify state flags updated'),
            ],
          )),
      infoCard(
          'Test Scenarios',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Undo after typing', 'Text should revert'),
              dataRow('Redo after undo', 'Text should re-apply'),
              dataRow('Undo at start', 'No-op, canUndo stays false'),
              dataRow('Redo at end', 'No-op, canRedo stays false'),
              dataRow('New edit after undo', 'Redo stack cleared'),
            ],
          )),
    ],
  );

  // ─── Section 15: Common Pitfalls ───
  print('[Section 15] Common Pitfalls');

  final pitfalls = <Map<String, String>>[
    {'issue': 'Too many snapshots', 'cause': 'Snapshot on every keystroke', 'fix': 'Group changes by time or word'},
    {'issue': 'Missing unregister', 'cause': 'Client not removed on dispose', 'fix': 'Unregister in dispose()'},
    {'issue': 'Stale state after undo', 'cause': 'UI not rebuilt after restore', 'fix': 'Notify listeners/setState'},
    {'issue': 'Undo does nothing', 'cause': 'Client not registered', 'fix': 'Register on focus gained'},
  ];

  final section15 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('15', 'Common Pitfalls'),
      for (final p in pitfalls)
        infoCard(
            p['issue']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Issue', p['issue']!),
                dataRow('Cause', p['cause']!),
                dataRow('Fix', p['fix']!),
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
      noteBox('Complete overview of the UndoManagerClient deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Burgundy', burgundy),
              colorSwatch('Wine', wine),
              colorSwatch('Deep Burg.', deepBurgundy),
              colorSwatch('Pale Rose', paleRose),
              colorSwatch('Claret', claret),
              colorSwatch('Blush', blush),
              colorSwatch('Maroon', maroon),
              colorSwatch('Rosewood', rosewood),
              colorSwatch('Plum', plum),
              colorSwatch('Garnet', garnet),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview', 1.0, burgundy),
              progressBar('Required Methods', 1.0, wine),
              progressBar('Stack Visualization', 1.0, claret),
              progressBar('Platform Integration', 1.0, garnet),
              progressBar('State Snapshots', 1.0, burgundy),
              progressBar('EditableTextState', 1.0, wine),
              progressBar('Client Registration', 1.0, claret),
              progressBar('Undo Grouping', 1.0, garnet),
              progressBar('canUndo/canRedo', 1.0, burgundy),
              progressBar('Custom Client', 1.0, wine),
              progressBar('Concurrency', 1.0, claret),
              progressBar('Android Differences', 1.0, garnet),
              progressBar('UndoHistory Widget', 1.0, burgundy),
              progressBar('Testing', 1.0, wine),
              progressBar('Common Pitfalls', 1.0, claret),
              progressBar('Dashboard', 1.0, garnet),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Burgundy / Wine'),
              dataRow('Palette colors', '10'),
              dataRow('Common pitfalls', '${pitfalls.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('UndoManagerClient', burgundy, Colors.white),
          tag('Undo/Redo', wine, Colors.white),
          tag('State Snapshots', claret, Colors.white),
          tag('NSUndoManager', maroon, Colors.white),
          tag('Platform Signals', garnet, Colors.white),
          tag('Grouping', rosewood, deepBurgundy),
        ],
      ),
    ],
  );

  print('===== END UNDO MANAGER CLIENT DEEP DEMO =====');

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
