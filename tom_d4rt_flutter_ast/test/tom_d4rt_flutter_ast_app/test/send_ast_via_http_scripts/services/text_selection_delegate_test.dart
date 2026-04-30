// ignore_for_file: avoid_print
// D4rt deep demo: TextSelectionDelegate — the mixin that connects
// editable text widgets to the system toolbar (cut/copy/paste/selectAll)
// and manages selection state, clipboard interaction, and user actions.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ─── Coral / Terracotta palette ───
  const Color coral = Color(0xFFF97316);
  const Color terracotta = Color(0xFFEA580C);
  const Color deepCoral = Color(0xFF9A3412);
  const Color paleApricot = Color(0xFFFFF7ED);
  const Color sienna = Color(0xFFC2410C);
  const Color peach = Color(0xFFFFEDD5);
  const Color rust = Color(0xFF7C2D12);
  const Color tangerine = Color(0xFFFB923C);
  const Color melon = Color(0xFFFED7AA);
  const Color papaya = Color(0xFFFF8C42);

  print('===== TEXT SELECTION DELEGATE DEEP DEMO =====');

  // ─── Local helpers ───

  Widget sectionBanner(String number, String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 24, bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [deepCoral, rust],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: deepCoral.withValues(alpha: 0.35),
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
              color: coral,
              borderRadius: BorderRadius.circular(17),
              border: Border.all(color: tangerine, width: 1.5),
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
        color: paleApricot,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: peach),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 13,
              color: deepCoral.withValues(alpha: 0.9),
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
        border: Border.all(color: peach),
        boxShadow: [
          BoxShadow(
            color: coral.withValues(alpha: 0.07),
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
              color: paleApricot,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Text(heading,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: deepCoral)),
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
            width: 155,
            child: Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: deepCoral)),
          ),
          Expanded(
            child: Text(value,
                style: TextStyle(fontSize: 12, color: rust)),
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
                  color: deepCoral.withValues(alpha: 0.2), width: 1),
            ),
          ),
          const SizedBox(height: 4),
          Text(name,
              style: TextStyle(fontSize: 9, color: deepCoral),
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
                  style: TextStyle(fontSize: 11, color: deepCoral)),
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
              color: melon,
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

  Widget toolbarButton(String label, IconData icon, Color bg, Color fg) {
    return Container(
      margin: const EdgeInsets.only(right: 8, bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: fg.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: fg)),
        ],
      ),
    );
  }

  Widget clipboardVisual(String content, bool hasContent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: hasContent ? paleApricot : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: hasContent ? coral : Colors.grey.shade300, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.content_paste,
              size: 20,
              color: hasContent ? coral : Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              hasContent ? content : '(empty clipboard)',
              style: TextStyle(
                fontSize: 12,
                fontStyle: hasContent ? FontStyle.normal : FontStyle.italic,
                color: hasContent ? deepCoral : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget selectionVisual(String text, int selStart, int selEnd, Color accent) {
    final before = text.substring(0, selStart.clamp(0, text.length));
    final selected = text.substring(
        selStart.clamp(0, text.length), selEnd.clamp(0, text.length));
    final after = text.substring(selEnd.clamp(0, text.length));
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: peach),
      ),
      child: Row(
        children: [
          Text(before, style: TextStyle(fontSize: 13, color: deepCoral)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Text(selected,
                style: TextStyle(
                    fontSize: 13,
                    color: deepCoral,
                    fontWeight: FontWeight.w600)),
          ),
          Text(after, style: TextStyle(fontSize: 13, color: deepCoral)),
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
          'TextSelectionDelegate is a mixin that defines the interface '
          'between editable text widgets and the system selection toolbar. '
          'It provides the contract for cut, copy, paste, and selectAll '
          'operations, and manages how selection changes propagate back '
          'to the text editing controller.'),
      infoCard(
          'Core Identity',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Type', 'Mixin'),
              dataRow('Package', 'flutter/services'),
              dataRow('Purpose', 'Toolbar action contract'),
              dataRow('Primary user', 'EditableTextState'),
              dataRow('Paired with', 'TextSelectionControls'),
            ],
          )),
      infoCard(
          'Why It Exists',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Decoupling', 'Separate selection from widget'),
              dataRow('Toolbar API', 'Consistent cut/copy/paste contract'),
              dataRow('Clipboard', 'Standardized clipboard access'),
              dataRow('Extensibility', 'Custom selection behaviors'),
            ],
          )),
    ],
  );

  // ─── Section 2: Required Properties ───
  print('[Section 2] Required Properties');

  final section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('02', 'Required Properties'),
      noteBox(
          'TextSelectionDelegate requires implementing three key properties '
          'that expose the text editing state to the selection system.'),
      infoCard(
          'textEditingValue',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Property', 'textEditingValue'),
              dataRow('Type', 'TextEditingValue'),
              dataRow('Getter', 'Returns current text + selection'),
              dataRow('Setter', 'Updates text + selection'),
              dataRow('Observable', 'Changes trigger toolbar update'),
            ],
          )),
      infoCard(
          'bringIntoView()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'bringIntoView(TextPosition)'),
              dataRow('Purpose', 'Scroll position into viewport'),
              dataRow('Called when', 'Selection changes'),
              dataRow('Ensures', 'Cursor always visible'),
            ],
          )),
      infoCard(
          'hideToolbar()',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Method', 'hideToolbar()'),
              dataRow('Purpose', 'Dismiss the selection toolbar'),
              dataRow('Called when', 'After toolbar action completes'),
              dataRow('Also', 'When focus is lost'),
            ],
          )),
    ],
  );

  // ─── Section 3: Cut, Copy, Paste, SelectAll ───
  print('[Section 3] Cut, Copy, Paste, SelectAll');

  final section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('03', 'Cut, Copy, Paste, SelectAll'),
      noteBox(
          'The four core toolbar actions are the heart of '
          'TextSelectionDelegate. Each action has specific behavior '
          'regarding the selection, clipboard, and text state.'),
      infoCard(
          'Cut',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectionVisual('Hello beautiful World', 6, 15, coral),
              dataRow('Action', 'Copy selected text to clipboard'),
              dataRow('Then', 'Delete selected text'),
              dataRow('Result', '"Hello  World" + clipboard has "beautiful"'),
              dataRow('No selection', 'Operation is a no-op'),
            ],
          )),
      infoCard(
          'Copy',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectionVisual('Hello beautiful World', 6, 15, terracotta),
              dataRow('Action', 'Copy selected text to clipboard'),
              dataRow('Then', 'Collapse selection (deselect)'),
              dataRow('Result', 'Text unchanged, clipboard has "beautiful"'),
              dataRow('No selection', 'Operation is a no-op'),
            ],
          )),
      infoCard(
          'Paste',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              clipboardVisual('beautiful', true),
              dataRow('Action', 'Read text from clipboard'),
              dataRow('Then', 'Replace selection with clipboard text'),
              dataRow('Empty clipboard', 'No-op (nothing to paste)'),
              dataRow('Collapsed cursor', 'Inserts at cursor position'),
            ],
          )),
      infoCard(
          'SelectAll',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectionVisual('Hello beautiful World', 0, 21, sienna),
              dataRow('Action', 'Select entire text content'),
              dataRow('Base', 'TextPosition(offset: 0)'),
              dataRow('Extent', 'TextPosition(offset: text.length)'),
              dataRow('Then', 'Show toolbar for next action'),
            ],
          )),
    ],
  );

  // ─── Section 4: The Selection Toolbar ───
  print('[Section 4] The Selection Toolbar');

  final section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('04', 'The Selection Toolbar'),
      noteBox(
          'The selection toolbar is the floating UI that appears above or '
          'below selected text, offering Cut/Copy/Paste buttons. '
          'TextSelectionDelegate is what those buttons call.'),
      infoCard(
          'Toolbar Anatomy',
          Wrap(
            children: [
              toolbarButton('Cut', Icons.content_cut, paleApricot, coral),
              toolbarButton('Copy', Icons.content_copy, paleApricot, terracotta),
              toolbarButton('Paste', Icons.content_paste, paleApricot, sienna),
              toolbarButton('Select All', Icons.select_all, paleApricot, rust),
            ],
          )),
      infoCard(
          'Button Visibility Rules',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Cut', 'Shown when text is selected + not readOnly'),
              dataRow('Copy', 'Shown when text is selected'),
              dataRow('Paste', 'Shown when clipboard has text'),
              dataRow('Select All', 'Shown when not all text already selected'),
            ],
          )),
      infoCard(
          'Toolbar Positioning',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Preferred', 'Above the selection'),
              dataRow('Fallback', 'Below if no space above'),
              dataRow('Anchored to', 'Selection start/end handles'),
              dataRow('Adaptive', 'Material, Cupertino, Desktop styles'),
            ],
          )),
    ],
  );

  // ─── Section 5: Clipboard Interaction ───
  print('[Section 5] Clipboard Interaction');

  final section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('05', 'Clipboard Interaction'),
      noteBox(
          'TextSelectionDelegate interacts with the system clipboard '
          'through the Clipboard class. This enables data exchange '
          'between the app and other applications.'),
      infoCard(
          'Clipboard API',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Clipboard.setData()', 'Write to clipboard'),
              dataRow('Clipboard.getData()', 'Read from clipboard'),
              dataRow('Clipboard.hasStrings()', 'Check if text available'),
              dataRow('Format', 'ClipboardData(text: ...)'),
            ],
          )),
      infoCard(
          'Cut Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              clipboardVisual('(previous content)', true),
              selectionVisual('selected text here', 0, 13, coral),
              clipboardVisual('selected text', true),
              dataRow('1. Read selection', 'Get selected text from value'),
              dataRow('2. Write clipboard', 'Clipboard.setData(selection)'),
              dataRow('3. Delete selection', 'Replace selection with empty'),
              dataRow('4. Hide toolbar', 'hideToolbar()'),
            ],
          )),
      infoCard(
          'Paste Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              clipboardVisual('pasted content', true),
              dataRow('1. Read clipboard', 'Clipboard.getData(plainText)'),
              dataRow('2. Validate', 'Check non-null, non-empty'),
              dataRow('3. Replace selection', 'Insert at cursor/selection'),
              dataRow('4. Update value', 'Set new textEditingValue'),
            ],
          )),
    ],
  );

  // ─── Section 6: TextEditingValue ───
  print('[Section 6] TextEditingValue');

  final section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('06', 'TextEditingValue'),
      noteBox(
          'TextEditingValue is the immutable state object that the delegate '
          'reads and writes. It encapsulates the full text, cursor position, '
          'selection range, and composing region.'),
      infoCard(
          'TextEditingValue Components',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('text', 'The full string content'),
              dataRow('selection', 'TextSelection (base + extent)'),
              dataRow('composing', 'TextRange for IME composition'),
            ],
          )),
      infoCard(
          'Immutability Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Read', 'delegate.textEditingValue'),
              dataRow('Modify', 'value.copyWith(text: ..., selection: ...)'),
              dataRow('Write', 'delegate.textEditingValue = newValue'),
              dataRow('Never mutate', 'Always create new instances'),
            ],
          )),
      infoCard(
          'Selection States',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectionVisual('Flutter is great', 12, 12, coral),
              dataRow('Collapsed', 'base == extent (cursor only)'),
              const SizedBox(height: 6),
              selectionVisual('Flutter is great', 0, 7, terracotta),
              dataRow('Forward', 'base < extent (left to right)'),
              const SizedBox(height: 6),
              selectionVisual('Flutter is great', 11, 16, sienna),
              dataRow('Selection', 'Any range where base != extent'),
            ],
          )),
    ],
  );

  // ─── Section 7: Selection Handles ───
  print('[Section 7] Selection Handles');

  final section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('07', 'Selection Handles'),
      noteBox(
          'Selection handles are the draggable markers at the edges of a '
          'text selection. They work closely with the delegate to update '
          'the selection range as the user drags.'),
      infoCard(
          'Handle Types',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Left handle', 'At selection.start (base)'),
              dataRow('Right handle', 'At selection.extent'),
              dataRow('Collapsed handle', 'Single caret cursor'),
              dataRow('Style', 'Platform-specific (teardrop, bar)'),
            ],
          )),
      infoCard(
          'Drag Behavior',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Start drag', 'Record initial position'),
              dataRow('During drag', 'Update selection continuously'),
              dataRow('End drag', 'Finalize selection, show toolbar'),
              dataRow('Crossing', 'Handles can swap sides'),
            ],
          )),
      infoCard(
          'Handle Events',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('onSelectionHandleTapped', 'Toggle toolbar'),
              dataRow('onSelectionHandleDragStart', 'Begin drag'),
              dataRow('onSelectionHandleDragUpdate', 'Ongoing drag'),
              dataRow('onSelectionHandleDragEnd', 'Finalize'),
            ],
          )),
    ],
  );

  // ─── Section 8: TextSelectionControls ───
  print('[Section 8] TextSelectionControls');

  final section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('08', 'TextSelectionControls'),
      noteBox(
          'TextSelectionControls is the companion class that builds the '
          'actual toolbar and handle widgets. It receives the delegate '
          'as a parameter and calls delegate methods on button taps.'),
      infoCard(
          'Relationship',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('TextSelectionDelegate', 'What to do (cut/copy/paste)'),
              dataRow('TextSelectionControls', 'How it looks (UI widgets)'),
              dataRow('Who builds toolbar', 'Controls builds toolbar'),
              dataRow('Who handles actions', 'Delegate handles actions'),
            ],
          )),
      infoCard(
          'Built-In Controls',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('materialTextSelectionControls', 'Material Design'),
              dataRow('cupertinoTextSelectionControls', 'iOS style'),
              dataRow('desktopTextSelectionControls', 'Desktop style'),
              dataRow('Custom', 'Extend TextSelectionControls'),
            ],
          )),
    ],
  );

  // ─── Section 9: Focus and Lifecycle ───
  print('[Section 9] Focus and Lifecycle');

  final section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('09', 'Focus and Lifecycle'),
      noteBox(
          'The delegate is active only when its text field has focus. '
          'Losing focus hides the toolbar and handles, while gaining '
          'focus enables selection operations.'),
      infoCard(
          'Focus Gained',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Keyboard', 'Opens (if applicable)'),
              dataRow('Cursor', 'Visible and blinking'),
              dataRow('Selection', 'Handles appear if text selected'),
              dataRow('Delegate', 'Ready for toolbar actions'),
            ],
          )),
      infoCard(
          'Focus Lost',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Keyboard', 'Closes'),
              dataRow('Cursor', 'Hidden'),
              dataRow('Selection', 'Handles removed'),
              dataRow('Toolbar', 'hideToolbar() called'),
            ],
          )),
      infoCard(
          'Lifecycle Events',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('initState', 'Register as delegate'),
              dataRow('didUpdateWidget', 'Re-register if needed'),
              dataRow('dispose', 'Cleanup handles and toolbar'),
              dataRow('deactivate', 'Hide toolbar temporarily'),
            ],
          )),
    ],
  );

  // ─── Section 10: Read-Only Mode ───
  print('[Section 10] Read-Only Mode');

  final section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('10', 'Read-Only Mode'),
      noteBox(
          'When the text widget is read-only, the delegate disables '
          'destructive operations (cut and paste) but still allows '
          'copy and selectAll for text consumption.'),
      infoCard(
          'Toolbar in Read-Only',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Cut', 'Hidden (destructive)'),
              dataRow('Copy', 'Shown (non-destructive)'),
              dataRow('Paste', 'Hidden (destructive)'),
              dataRow('Select All', 'Shown (non-destructive)'),
            ],
          )),
      infoCard(
          'Use Cases',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Code display', 'Select and copy code snippets'),
              dataRow('License text', 'Users can copy but not edit'),
              dataRow('Chat bubbles', 'Copy message text'),
              dataRow('Output logs', 'Select and copy log entries'),
            ],
          )),
      infoCard(
          'Implementation',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('readOnly property', 'On EditableText widget'),
              dataRow('Check in canCut', 'Return false if readOnly'),
              dataRow('Check in canPaste', 'Return false if readOnly'),
              dataRow('Keyboard', 'May not show (showKeyboard: false)'),
            ],
          )),
    ],
  );

  // ─── Section 11: Keyboard Shortcuts ───
  print('[Section 11] Keyboard Shortcuts');

  final shortcuts = <Map<String, String>>[
    {'shortcut': 'Ctrl+C / Cmd+C', 'action': 'Copy', 'method': 'copySelection()'},
    {'shortcut': 'Ctrl+X / Cmd+X', 'action': 'Cut', 'method': 'cutSelection()'},
    {'shortcut': 'Ctrl+V / Cmd+V', 'action': 'Paste', 'method': 'pasteText()'},
    {'shortcut': 'Ctrl+A / Cmd+A', 'action': 'Select All', 'method': 'selectAll()'},
    {'shortcut': 'Ctrl+Z / Cmd+Z', 'action': 'Undo', 'method': 'Not in delegate'},
    {'shortcut': 'Ctrl+Shift+Z', 'action': 'Redo', 'method': 'Not in delegate'},
  ];

  final section11 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('11', 'Keyboard Shortcuts'),
      noteBox(
          'Desktop and web platforms use keyboard shortcuts for the same '
          'operations. These shortcuts call the same delegate methods as '
          'the toolbar buttons.'),
      for (final s in shortcuts)
        infoCard(
            s['shortcut']!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                dataRow('Shortcut', s['shortcut']!),
                dataRow('Action', s['action']!),
                dataRow('Delegate method', s['method']!),
              ],
            )),
    ],
  );

  // ─── Section 12: Custom Toolbar Actions ───
  print('[Section 12] Custom Toolbar Actions');

  final section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('12', 'Custom Toolbar Actions'),
      noteBox(
          'Beyond the standard cut/copy/paste, apps can add custom '
          'toolbar actions like "Translate", "Search", "Share", or '
          '"Format" by extending the toolbar controls.'),
      infoCard(
          'Custom Action Examples',
          Wrap(
            children: [
              toolbarButton('Translate', Icons.translate, peach, coral),
              toolbarButton('Search', Icons.search, peach, terracotta),
              toolbarButton('Share', Icons.share, peach, sienna),
              toolbarButton('Bold', Icons.format_bold, peach, rust),
              toolbarButton('Link', Icons.link, peach, papaya),
            ],
          )),
      infoCard(
          'Implementation Pattern',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Step 1', 'Extend TextSelectionControls'),
              dataRow('Step 2', 'Override buildToolbar()'),
              dataRow('Step 3', 'Add custom buttons to toolbar'),
              dataRow('Step 4', 'Access delegate.textEditingValue'),
              dataRow('Step 5', 'Perform action on selected text'),
            ],
          )),
      infoCard(
          'contextMenuBuilder',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Modern approach', 'contextMenuBuilder parameter'),
              dataRow('On TextField', 'contextMenuBuilder: (ctx, state) {}'),
              dataRow('Provides', 'EditableTextState with delegate'),
              dataRow('Return', 'Custom widget with toolbar actions'),
            ],
          )),
    ],
  );

  // ─── Section 13: Platform Differences ───
  print('[Section 13] Platform Differences');

  final section13 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('13', 'Platform Differences'),
      noteBox(
          'Each platform has different selection toolbar styles and '
          'behaviors. TextSelectionDelegate provides consistent behavior '
          'while the platform controls handle visual differences.'),
      infoCard(
          'Android (Material)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Toolbar', 'Floating above selection'),
              dataRow('Handles', 'Teardrop shape'),
              dataRow('Extra actions', 'Share, Web Search'),
              dataRow('Long press', 'Select word + magnifier'),
            ],
          )),
      infoCard(
          'iOS (Cupertino)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Toolbar', 'Pill-shaped above/below'),
              dataRow('Handles', 'Circle at line height'),
              dataRow('Extra actions', 'Look Up, Translate, Share'),
              dataRow('Long press', 'Select word + loupe'),
            ],
          )),
      infoCard(
          'Desktop (macOS, Windows, Linux)',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Toolbar', 'Right-click context menu'),
              dataRow('Handles', 'None (mouse cursor)'),
              dataRow('Shortcuts', 'Ctrl/Cmd + C/X/V/A'),
              dataRow('Selection', 'Click-and-drag'),
            ],
          )),
    ],
  );

  // ─── Section 14: Accessibility ───
  print('[Section 14] Accessibility');

  final section14 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sectionBanner('14', 'Accessibility'),
      noteBox(
          'TextSelectionDelegate supports accessibility through semantic '
          'actions. Screen readers provide cut/copy/paste actions in their '
          'own UI, which call the same delegate methods.'),
      infoCard(
          'Semantic Actions',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('SemanticsAction.cut', 'Calls delegate.cutSelection'),
              dataRow('SemanticsAction.copy', 'Calls delegate.copySelection'),
              dataRow('SemanticsAction.paste', 'Calls delegate.pasteText'),
              dataRow('onDidGainAccessibilityFocus', 'Announce selection'),
            ],
          )),
      infoCard(
          'Screen Reader Flow',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('1. Focus field', 'Announce hint text or value'),
              dataRow('2. Select text', 'Announce selected range'),
              dataRow('3. Action menu', 'Offer cut/copy/paste actions'),
              dataRow('4. Perform action', 'Call delegate method'),
            ],
          )),
    ],
  );

  // ─── Section 15: Common Pitfalls ───
  print('[Section 15] Common Pitfalls');

  final pitfalls = <Map<String, String>>[
    {'issue': 'Paste returns null', 'cause': 'Clipboard empty or format mismatch', 'fix': 'Check Clipboard.hasStrings() first'},
    {'issue': 'Toolbar not showing', 'cause': 'No selection or focus lost', 'fix': 'Verify textEditingValue.selection.isValid'},
    {'issue': 'Cut does nothing', 'cause': 'readOnly is true', 'fix': 'Check readOnly flag before action'},
    {'issue': 'Selection lost on rebuild', 'cause': 'Controller recreated', 'fix': 'Preserve controller across rebuilds'},
    {'issue': 'Toolbar clips offscreen', 'cause': 'Selection near edges', 'fix': 'Toolbar auto-repositions but check overlay'},
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
      noteBox('Complete overview of the TextSelectionDelegate deep demo.'),
      infoCard(
          'Demo Color Palette',
          Wrap(
            children: [
              colorSwatch('Coral', coral),
              colorSwatch('Terracotta', terracotta),
              colorSwatch('Deep Coral', deepCoral),
              colorSwatch('Pale Apricot', paleApricot),
              colorSwatch('Sienna', sienna),
              colorSwatch('Peach', peach),
              colorSwatch('Rust', rust),
              colorSwatch('Tangerine', tangerine),
              colorSwatch('Melon', melon),
              colorSwatch('Papaya', papaya),
            ],
          )),
      infoCard(
          'Section Coverage',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              progressBar('Overview & Purpose', 1.0, coral),
              progressBar('Required Properties', 1.0, terracotta),
              progressBar('Cut/Copy/Paste/SelectAll', 1.0, sienna),
              progressBar('Selection Toolbar', 1.0, papaya),
              progressBar('Clipboard Interaction', 1.0, coral),
              progressBar('TextEditingValue', 1.0, terracotta),
              progressBar('Selection Handles', 1.0, sienna),
              progressBar('TextSelectionControls', 1.0, papaya),
              progressBar('Focus & Lifecycle', 1.0, coral),
              progressBar('Read-Only Mode', 1.0, terracotta),
              progressBar('Keyboard Shortcuts', 1.0, sienna),
              progressBar('Custom Toolbar', 1.0, papaya),
              progressBar('Platform Differences', 1.0, coral),
              progressBar('Accessibility', 1.0, terracotta),
              progressBar('Common Pitfalls', 1.0, sienna),
              progressBar('Dashboard', 1.0, papaya),
            ],
          )),
      infoCard(
          'Statistics',
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dataRow('Total sections', '16'),
              dataRow('Theme', 'Coral / Terracotta'),
              dataRow('Palette colors', '10'),
              dataRow('Keyboard shortcuts', '${shortcuts.length}'),
              dataRow('Common pitfalls', '${pitfalls.length}'),
            ],
          )),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: [
          tag('TextSelectionDelegate', coral, Colors.white),
          tag('Cut/Copy/Paste', terracotta, Colors.white),
          tag('Clipboard', sienna, Colors.white),
          tag('Toolbar Actions', papaya, deepCoral),
          tag('Selection Handles', rust, Colors.white),
          tag('Accessibility', tangerine, deepCoral),
        ],
      ),
    ],
  );

  print('===== END TEXT SELECTION DELEGATE DEEP DEMO =====');

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
