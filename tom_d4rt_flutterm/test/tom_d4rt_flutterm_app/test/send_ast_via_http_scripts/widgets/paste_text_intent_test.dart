// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

/// PasteTextIntent — Complete Deep Dive
///
/// Palette: Indigo / Sapphire (deep blue spectrum)
/// Primary:   Color(0xFF3F51B5) — Indigo 500
/// Secondary: Color(0xFF5C6BC0) — Indigo 400
/// Accent:    Color(0xFF7986CB) — Indigo 300
/// Surface:   Color(0xFFE8EAF6) — Indigo 50
/// Deep:      Color(0xFF1A237E) — Indigo 900
/// Muted:     Color(0xFF9FA8DA) — Indigo 200
/// Warm:      Color(0xFF3949AB) — Indigo 600
/// Highlight: Color(0xFFC5CAE9) — Indigo 100
/// Light:     Color(0xFFF3F4FB) — Near-white indigo
/// Dark:      Color(0xFF283593) — Indigo 800

dynamic build(BuildContext context) {
  // ─── Section 1: Title Banner ───
  print('');
  print('████████████████████████████████████████████████████████████');
  print('██                                                      ██');
  print('██   PasteTextIntent — Complete Deep Dive                ██');
  print('██   Intent for text paste actions in TextField          ██');
  print('██                                                      ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  const indigo500 = Color(0xFF3F51B5);
  const indigo400 = Color(0xFF5C6BC0);
  const indigo300 = Color(0xFF7986CB);
  const indigo50 = Color(0xFFE8EAF6);
  const indigo900 = Color(0xFF1A237E);
  const indigo200 = Color(0xFF9FA8DA);
  const indigo600 = Color(0xFF3949AB);
  const indigo100 = Color(0xFFC5CAE9);
  const nearWhite = Color(0xFFF3F4FB);
  const indigo800 = Color(0xFF283593);

  // ─── Section 2: What Is PasteTextIntent? ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 2: What Is PasteTextIntent?');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PasteTextIntent is the Intent object that represents');
  print('  a paste action (Ctrl+V / Cmd+V) within Flutter\'s');
  print('  Actions and Shortcuts framework.');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class PasteTextIntent extends Intent {              │');
  print('  │    const PasteTextIntent(this.cause);                │');
  print('  │    final SelectionChangedCause cause;                │');
  print('  │  }                                                   │');
  print('  │                                                      │');
  print('  │  That is the ENTIRE class. Only 3 lines of real code.│');
  print('  │  Its power comes from how it fits into the larger    │');
  print('  │  Actions/Shortcuts architecture.                     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 3: Actions/Shortcuts Architecture ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 3: Actions/Shortcuts Architecture');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PasteTextIntent lives in the middle of a 3-layer');
  print('  architecture for keyboard-driven text editing:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Layer 1: Shortcuts (Key Binding)                     │');
  print('  │  ┌──────────────────────────────────────────────┐    │');
  print('  │  │ SingleActivator(LogicalKeyboardKey.keyV,     │    │');
  print('  │  │   control: true)  // Ctrl+V on Linux/Win     │    │');
  print('  │  │   meta: true)     // Cmd+V on macOS          │    │');
  print('  │  │   → PasteTextIntent(SelectionChangedCause    │    │');
  print('  │  │       .keyboard)                              │    │');
  print('  │  └──────────────────────────────────────────────┘    │');
  print('  │         │                                             │');
  print('  │         ▼                                             │');
  print('  │  Layer 2: Intent (What to do)                         │');
  print('  │  ┌──────────────────────────────────────────────┐    │');
  print('  │  │ PasteTextIntent(cause: .keyboard)            │    │');
  print('  │  │   → "Paste clipboard text into the active    │    │');
  print('  │  │      editable field"                          │    │');
  print('  │  └──────────────────────────────────────────────┘    │');
  print('  │         │                                             │');
  print('  │         ▼                                             │');
  print('  │  Layer 3: Action (How to do it)                       │');
  print('  │  ┌──────────────────────────────────────────────┐    │');
  print('  │  │ _PasteSelectionAction inside EditableText    │    │');
  print('  │  │   → reads clipboard                           │    │');
  print('  │  │   → replaces selection with pasted text       │    │');
  print('  │  │   → uses intent.cause to set selection cause  │    │');
  print('  │  └──────────────────────────────────────────────┘    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 4: SelectionChangedCause ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 4: SelectionChangedCause');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PasteTextIntent carries a cause to indicate HOW the');
  print('  paste was triggered:');
  print('');
  print('  ┌────────────────────┬──────────────────────────────────┐');
  print('  │  Cause              │  When used                      │');
  print('  ├────────────────────┼──────────────────────────────────┤');
  print('  │  .keyboard          │  Ctrl+V / Cmd+V / Shift+Insert │');
  print('  │  .tap               │  Tap on "Paste" in context menu │');
  print('  │  .longPress         │  Long-press paste on mobile      │');
  print('  │  .forcePress        │  Force-touch paste (3D Touch)    │');
  print('  │  .toolbar           │  Toolbar button press            │');
  print('  │  .drag              │  Drag-and-drop text              │');
  print('  │  .scribble          │  Apple Pencil scribble paste     │');
  print('  └────────────────────┴──────────────────────────────────┘');
  print('');
  print('  The cause affects:');
  print('  • Whether to show selection handles after paste');
  print('  • Whether to scroll to the cursor position');
  print('  • Analytics for how users interact with text');
  print('');

  // ─── Section 5: Inheritance Chain ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 5: Inheritance Chain');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('       ┌──────────────────────┐');
  print('       │  Diagnosticable      │  Debug info');
  print('       └──────────┬───────────┘');
  print('                  │');
  print('       ┌──────────┴───────────┐');
  print('       │  Intent              │  Abstract: "what to do"');
  print('       │                      │  Paired with Action');
  print('       └──────────┬───────────┘');
  print('                  │');
  print('       ┌──────────┴───────────┐');
  print('       │  PasteTextIntent     │  "paste clipboard text"');
  print('       │  .cause: SCCC        │');
  print('       └──────────────────────┘');
  print('');
  print('  Sibling Intent classes:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  • CopySelectionTextIntent  — Ctrl+C / Cmd+C        │');
  print('  │  • CutSelectionTextIntent   — Ctrl+X / Cmd+X        │');
  print('  │  • PasteTextIntent          — Ctrl+V / Cmd+V        │');
  print('  │  • SelectAllTextIntent      — Ctrl+A / Cmd+A        │');
  print('  │  • DeleteCharacterIntent    — Backspace / Delete     │');
  print('  │  • UndoTextIntent           — Ctrl+Z / Cmd+Z        │');
  print('  │  • RedoTextIntent           — Ctrl+Shift+Z          │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 6: DefaultTextEditingShortcuts ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 6: DefaultTextEditingShortcuts');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The binding from keyboard to PasteTextIntent happens');
  print('  in DefaultTextEditingShortcuts, which is installed');
  print('  by WidgetsApp / MaterialApp:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  // Platform-specific bindings:                       │');
  print('  │                                                       │');
  print('  │  Linux/Windows:                                       │');
  print('  │    Ctrl+V → PasteTextIntent(.keyboard)               │');
  print('  │    Shift+Insert → PasteTextIntent(.keyboard)         │');
  print('  │                                                       │');
  print('  │  macOS:                                               │');
  print('  │    Cmd+V → PasteTextIntent(.keyboard)                │');
  print('  │                                                       │');
  print('  │  Android/iOS:                                         │');
  print('  │    Same as desktop when hardware keyboard attached    │');
  print('  │    Context menu "Paste" → PasteTextIntent(.toolbar)  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 7: EditableText Action Handler ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 7: EditableText Action Handler');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  Inside EditableText, a private _PasteSelectionAction');
  print('  handles PasteTextIntent:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  class _PasteSelectionAction                          │');
  print('  │      extends ContextAction<PasteTextIntent> {         │');
  print('  │                                                       │');
  print('  │    @override                                          │');
  print('  │    void invoke(PasteTextIntent intent, [ctx]) {       │');
  print('  │      // 1. Read clipboard data                        │');
  print('  │      final data = await Clipboard.getData(format);    │');
  print('  │                                                       │');
  print('  │      // 2. Replace current selection with pasted text │');
  print('  │      controller.value = controller.value.replaced(    │');
  print('  │        controller.selection,                          │');
  print('  │        data.text,                                     │');
  print('  │      );                                               │');
  print('  │                                                       │');
  print('  │      // 3. Move cursor after pasted text              │');
  print('  │      // 4. Use intent.cause for selection cause       │');
  print('  │    }                                                   │');
  print('  │  }                                                     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 8: Intent/Action Pairing ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 8: Intent/Action Pairing Pattern');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  The Actions widget maps Intent types to Actions:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Actions(                                             │');
  print('  │    actions: <Type, Action<Intent>>{                   │');
  print('  │      PasteTextIntent: _PasteAction(),                 │');
  print('  │      CopySelectionTextIntent: _CopyAction(),          │');
  print('  │      CutSelectionTextIntent: _CutAction(),            │');
  print('  │      SelectAllTextIntent: _SelectAllAction(),         │');
  print('  │    },                                                 │');
  print('  │    child: editableText,                               │');
  print('  │  )                                                    │');
  print('  │                                                       │');
  print('  │  When PasteTextIntent is dispatched, Flutter walks    │');
  print('  │  up the element tree looking for an Actions widget    │');
  print('  │  that has a handler for PasteTextIntent.type.         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 9: Custom Override ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 9: Custom Paste Override Pattern');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  You can intercept PasteTextIntent to customize paste:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  // Example: Strip formatting on paste                │');
  print('  │  Actions(                                             │');
  print('  │    actions: {                                         │');
  print('  │      PasteTextIntent: CallbackAction<PasteTextIntent>(│');
  print('  │        onInvoke: (intent) {                           │');
  print('  │          // Read clipboard, strip HTML, insert plain  │');
  print('  │          return null;                                 │');
  print('  │        },                                             │');
  print('  │      ),                                               │');
  print('  │    },                                                 │');
  print('  │    child: TextField(...),                             │');
  print('  │  )                                                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');
  print('  Use cases for custom paste handlers:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  • Strip formatting (paste as plain text)             │');
  print('  │  • Validate input before paste (phone, email format)  │');
  print('  │  • Transform pasted text (uppercase, trim whitespace) │');
  print('  │  • Log paste events for audit trails                  │');
  print('  │  • Block paste in read-only-ish fields                │');
  print('  │  • Auto-fill from pasted OTP codes                    │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 10: Programmatic Dispatch ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 10: Programmatic Dispatch');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  You can programmatically invoke a paste action:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  // From a button or other trigger:                   │');
  print('  │  Actions.invoke(                                      │');
  print('  │    context,                                           │');
  print('  │    const PasteTextIntent(                             │');
  print('  │      SelectionChangedCause.toolbar,                   │');
  print('  │    ),                                                 │');
  print('  │  );                                                   │');
  print('  │                                                       │');
  print('  │  // Or find and invoke the action directly:           │');
  print('  │  final action = Actions.find<PasteTextIntent>(ctx);   │');
  print('  │  action.invoke(pasteIntent);                          │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 11: Clipboard Integration ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 11: Clipboard Integration');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PasteTextIntent connects to the system clipboard:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  PasteTextIntent dispatched                           │');
  print('  │       │                                               │');
  print('  │       ▼                                               │');
  print('  │  _PasteSelectionAction.invoke()                       │');
  print('  │       │                                               │');
  print('  │       ▼                                               │');
  print('  │  Clipboard.getData(Clipboard.kTextPlain)              │');
  print('  │       │                                               │');
  print('  │       ▼                                               │');
  print('  │  Platform channel → system clipboard                  │');
  print('  │       │                                               │');
  print('  │       ▼                                               │');
  print('  │  ClipboardData(text: ...)                             │');
  print('  │       │                                               │');
  print('  │       ▼                                               │');
  print('  │  TextEditingController.value = replaced value         │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 12: Comparison With Sibling Intents ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 12: Comparison With Sibling Intents');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌────────────────────────────┬───────────┬─────────────┐');
  print('  │  Intent                     │  Property │  Clipboard  │');
  print('  ├────────────────────────────┼───────────┼─────────────┤');
  print('  │  PasteTextIntent            │  cause    │  Reads      │');
  print('  │  CopySelectionTextIntent    │  cause    │  Writes     │');
  print('  │  CutSelectionTextIntent     │  cause    │  Writes     │');
  print('  │  SelectAllTextIntent        │  cause    │  Neither    │');
  print('  │  DeleteCharacterIntent      │  forward  │  Neither    │');
  print('  │  UndoTextIntent             │  (none)   │  Neither    │');
  print('  │  RedoTextIntent             │  (none)   │  Neither    │');
  print('  └────────────────────────────┴───────────┴─────────────┘');
  print('');
  print('  PasteTextIntent is the only read-from-clipboard intent.');
  print('  CopySelectionTextIntent and CutSelectionTextIntent');
  print('  write to the clipboard. All others are clipboard-neutral.');
  print('');

  // ─── Section 13: Platform Differences ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 13: Platform Differences');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────┬────────────────────────────────────┐');
  print('  │  Platform         │  Paste shortcut(s)                │');
  print('  ├──────────────────┼────────────────────────────────────┤');
  print('  │  macOS             │  Cmd+V                           │');
  print('  │  Windows           │  Ctrl+V, Shift+Insert            │');
  print('  │  Linux             │  Ctrl+V, Shift+Insert            │');
  print('  │  Android           │  Ctrl+V (hw keyboard) + toolbar  │');
  print('  │  iOS               │  Cmd+V (hw keyboard) + toolbar   │');
  print('  │  Web               │  Ctrl+V / Cmd+V (browser routing)│');
  print('  └──────────────────┴────────────────────────────────────┘');
  print('');
  print('  On mobile, paste typically comes from the context');
  print('  menu/toolbar with SelectionChangedCause.toolbar');
  print('  rather than .keyboard.');
  print('');

  // ─── Section 14: Security Considerations ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 14: Security Considerations');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Clipboard paste is a security-sensitive operation:    │');
  print('  │                                                       │');
  print('  │  • iOS 16+ shows a paste permission dialog            │');
  print('  │  • Android 13+ shows clipboard preview                │');
  print('  │  • Web browsers may restrict clipboard access         │');
  print('  │  • Sensitive data (passwords) may be in clipboard     │');
  print('  │                                                       │');
  print('  │  Best practices:                                      │');
  print('  │  • Validate pasted content before using               │');
  print('  │  • Don\'t auto-paste without user action              │');
  print('  │  • Clear clipboard after sensitive paste              │');
  print('  │  • Handle clipboard permission denials gracefully     │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  // ─── Section 15: Live Interactive Demo ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 15: Live Interactive Demo');
  print('═══════════════════════════════════════════════════════════');
  print('');

  // Build the visual demo
  final demo = Scaffold(
    backgroundColor: nearWhite,
    appBar: AppBar(
      title: const Text(
        'PasteTextIntent — Visual Demo',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      backgroundColor: indigo900,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Architecture diagram card ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [indigo900, indigo800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shortcuts → Intent → Action Pipeline',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                // Pipeline visualization
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.keyboard,
                              color: indigo200,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Ctrl+V',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Shortcut',
                              style: TextStyle(
                                color: indigo300,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: indigo300,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: indigo500.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: indigo400),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.content_paste,
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'PasteText\nIntent',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.arrow_forward,
                        color: indigo300,
                        size: 20,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.play_circle_outline,
                              color: indigo200,
                              size: 28,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Action',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Handler',
                              style: TextStyle(
                                color: indigo300,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── SelectionChangedCause visual ──
          Text(
            'SelectionChangedCause Values',
            style: TextStyle(
              color: indigo900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCauseChip(
                label: '.keyboard',
                icon: Icons.keyboard,
                color: indigo500,
                description: 'Ctrl+V / Cmd+V',
              ),
              _buildCauseChip(
                label: '.toolbar',
                icon: Icons.content_paste,
                color: indigo600,
                description: 'Context menu',
              ),
              _buildCauseChip(
                label: '.tap',
                icon: Icons.touch_app,
                color: indigo400,
                description: 'Tap paste button',
              ),
              _buildCauseChip(
                label: '.longPress',
                icon: Icons.pan_tool,
                color: indigo300,
                description: 'Long press menu',
              ),
              _buildCauseChip(
                label: '.drag',
                icon: Icons.drag_indicator,
                color: Color(0xFF7E57C2),
                description: 'Drag and drop',
              ),
              _buildCauseChip(
                label: '.scribble',
                icon: Icons.edit,
                color: Color(0xFF5E35B1),
                description: 'Apple Pencil',
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── Sibling intents comparison ──
          Text(
            'Text Editing Intent Family',
            style: TextStyle(
              color: indigo900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: indigo100),
            ),
            child: Column(
              children: [
                _buildIntentRow(
                  icon: Icons.content_paste,
                  label: 'PasteTextIntent',
                  shortcut: 'Ctrl+V',
                  operation: 'Read clipboard',
                  color: indigo500,
                  isHighlighted: true,
                ),
                Divider(height: 1, color: indigo50),
                _buildIntentRow(
                  icon: Icons.content_copy,
                  label: 'CopySelectionTextIntent',
                  shortcut: 'Ctrl+C',
                  operation: 'Write clipboard',
                  color: indigo400,
                ),
                Divider(height: 1, color: indigo50),
                _buildIntentRow(
                  icon: Icons.content_cut,
                  label: 'CutSelectionTextIntent',
                  shortcut: 'Ctrl+X',
                  operation: 'Write clipboard',
                  color: indigo400,
                ),
                Divider(height: 1, color: indigo50),
                _buildIntentRow(
                  icon: Icons.select_all,
                  label: 'SelectAllTextIntent',
                  shortcut: 'Ctrl+A',
                  operation: 'No clipboard',
                  color: indigo300,
                ),
                Divider(height: 1, color: indigo50),
                _buildIntentRow(
                  icon: Icons.undo,
                  label: 'UndoTextIntent',
                  shortcut: 'Ctrl+Z',
                  operation: 'No clipboard',
                  color: indigo200,
                ),
                Divider(height: 1, color: indigo50),
                _buildIntentRow(
                  icon: Icons.redo,
                  label: 'RedoTextIntent',
                  shortcut: 'Ctrl+Y',
                  operation: 'No clipboard',
                  color: indigo200,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── TextField demo with paste area ──
          Text(
            'Live TextField — Paste Target',
            style: TextStyle(
              color: indigo900,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: indigo200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'When you press Ctrl+V here, a PasteTextIntent '
                  'is dispatched with cause: .keyboard',
                  style: TextStyle(
                    color: indigo800,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Paste text here (Ctrl+V)',
                    labelStyle: TextStyle(color: indigo400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: indigo200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: indigo500, width: 2),
                    ),
                    prefixIcon: Icon(Icons.content_paste, color: indigo400),
                    filled: true,
                    fillColor: indigo50,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Second field — same Intent, same Action',
                    labelStyle: TextStyle(color: indigo400),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: indigo200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: indigo500, width: 2),
                    ),
                    prefixIcon: Icon(Icons.text_fields, color: indigo400),
                    filled: true,
                    fillColor: indigo50,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.info_outline, color: indigo300, size: 14),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Each TextField has its own EditableText with its '
                        'own _PasteSelectionAction registered via Actions widget.',
                        style: TextStyle(
                          color: indigo400,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Platform shortcuts reference ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: indigo50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: indigo100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Platform Paste Shortcuts',
                  style: TextStyle(
                    color: indigo900,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                ...[
                  {'platform': 'macOS', 'keys': 'Cmd + V', 'icon': Icons.laptop_mac},
                  {'platform': 'Windows', 'keys': 'Ctrl + V / Shift + Insert', 'icon': Icons.desktop_windows},
                  {'platform': 'Linux', 'keys': 'Ctrl + V / Shift + Insert', 'icon': Icons.computer},
                  {'platform': 'Mobile', 'keys': 'Toolbar / Long Press', 'icon': Icons.phone_android},
                ].map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          color: indigo600,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 70,
                          child: Text(
                            item['platform'] as String,
                            style: TextStyle(
                              color: indigo800,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            item['keys'] as String,
                            style: TextStyle(
                              color: indigo600,
                              fontSize: 12,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  print('  Live widget built: PasteTextIntent visual demo');
  print('  • Shortcuts → Intent → Action pipeline visualization');
  print('  • SelectionChangedCause chip gallery (6 values)');
  print('  • Text editing intent family comparison (6 intents)');
  print('  • Two live TextFields for paste testing');
  print('  • Platform paste shortcuts reference');
  print('');

  // ─── Section 16: Summary ───
  print('');
  print('═══════════════════════════════════════════════════════════');
  print('  SECTION 16: Summary');
  print('═══════════════════════════════════════════════════════════');
  print('');
  print('  PasteTextIntent is a tiny class with big implications:');
  print('');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Key takeaways:                                      │');
  print('  │                                                      │');
  print('  │  1. Just 3 lines: extends Intent, holds cause        │');
  print('  │  2. cause is SelectionChangedCause (keyboard, etc.)  │');
  print('  │  3. Bound via DefaultTextEditingShortcuts             │');
  print('  │  4. Handled by _PasteSelectionAction in EditableText │');
  print('  │  5. Reads from system clipboard via platform channel │');
  print('  │  6. Can be overridden with custom Actions widget     │');
  print('  │  7. Can be programmatically dispatched                │');
  print('  │  8. Platform-aware shortcut bindings                  │');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('  Demo colors used:');
  print('  ┌──────────────────────────────────────────────────────┐');
  print('  │  Indigo 900 ${indigo900.toARGB32().toRadixString(16).padLeft(8, "0")}  Deep');
  print('  │  Indigo 800 ${indigo800.toARGB32().toRadixString(16).padLeft(8, "0")}  Dark');
  print('  │  Indigo 600 ${indigo600.toARGB32().toRadixString(16).padLeft(8, "0")}  Warm');
  print('  │  Indigo 500 ${indigo500.toARGB32().toRadixString(16).padLeft(8, "0")}  Primary');
  print('  │  Indigo 400 ${indigo400.toARGB32().toRadixString(16).padLeft(8, "0")}  Secondary');
  print('  │  Indigo 300 ${indigo300.toARGB32().toRadixString(16).padLeft(8, "0")}  Accent');
  print('  │  Indigo 200 ${indigo200.toARGB32().toRadixString(16).padLeft(8, "0")}  Muted');
  print('  │  Indigo 100 ${indigo100.toARGB32().toRadixString(16).padLeft(8, "0")}  Highlight');
  print('  │  Indigo 50  ${indigo50.toARGB32().toRadixString(16).padLeft(8, "0")}  Surface');
  print('  │  Near-white ${nearWhite.toARGB32().toRadixString(16).padLeft(8, "0")}  Light');
  print('  └──────────────────────────────────────────────────────┘');
  print('');

  print('████████████████████████████████████████████████████████████');
  print('██  PasteTextIntent — Demonstration Complete              ██');
  print('████████████████████████████████████████████████████████████');
  print('');

  return demo;
}

Widget _buildCauseChip({
  required String label,
  required IconData icon,
  required Color color,
  required String description,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                color: color.withValues(alpha: 0.7),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildIntentRow({
  required IconData icon,
  required String label,
  required String shortcut,
  required String operation,
  required Color color,
  bool isHighlighted = false,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    color: isHighlighted ? color.withValues(alpha: 0.08) : null,
    child: Row(
      children: [
        Icon(icon, color: color, size: 18),
        const SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: TextStyle(
              color: isHighlighted ? color : const Color(0xFF424242),
              fontSize: 12,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(
            shortcut,
            style: TextStyle(
              color: const Color(0xFF757575),
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(
            operation,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: color.withValues(alpha: 0.8),
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
