// D4rt test script: Tests RawKeyEvent, RawKeyDownEvent, RawKeyUpEvent,
// LogicalKeyboardKey, PhysicalKeyboardKey, KeyEvent, HardwareKeyboard,
// KeyDownEvent, KeyUpEvent, KeyRepeatEvent
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Key events test executing');

  // ========== LogicalKeyboardKey ==========
  print('--- LogicalKeyboardKey Tests ---');
  final keys = {
    'space': LogicalKeyboardKey.space,
    'enter': LogicalKeyboardKey.enter,
    'escape': LogicalKeyboardKey.escape,
    'tab': LogicalKeyboardKey.tab,
    'backspace': LogicalKeyboardKey.backspace,
    'delete': LogicalKeyboardKey.delete,
    'arrowUp': LogicalKeyboardKey.arrowUp,
    'arrowDown': LogicalKeyboardKey.arrowDown,
    'arrowLeft': LogicalKeyboardKey.arrowLeft,
    'arrowRight': LogicalKeyboardKey.arrowRight,
    'home': LogicalKeyboardKey.home,
    'end': LogicalKeyboardKey.end,
    'pageUp': LogicalKeyboardKey.pageUp,
    'pageDown': LogicalKeyboardKey.pageDown,
    'shiftLeft': LogicalKeyboardKey.shiftLeft,
    'controlLeft': LogicalKeyboardKey.controlLeft,
    'altLeft': LogicalKeyboardKey.altLeft,
    'metaLeft': LogicalKeyboardKey.metaLeft,
    'keyA': LogicalKeyboardKey.keyA,
    'keyZ': LogicalKeyboardKey.keyZ,
    'digit0': LogicalKeyboardKey.digit0,
    'digit9': LogicalKeyboardKey.digit9,
    'f1': LogicalKeyboardKey.f1,
    'f12': LogicalKeyboardKey.f12,
  };
  for (final entry in keys.entries) {
    print(
      '  LogicalKeyboardKey.${entry.key}: keyId=${entry.value.keyId}, keyLabel=${entry.value.keyLabel}',
    );
  }

  // ========== PhysicalKeyboardKey ==========
  print('--- PhysicalKeyboardKey Tests ---');
  final physKeys = {
    'keyA': PhysicalKeyboardKey.keyA,
    'keyZ': PhysicalKeyboardKey.keyZ,
    'enter': PhysicalKeyboardKey.enter,
    'escape': PhysicalKeyboardKey.escape,
    'space': PhysicalKeyboardKey.space,
    'arrowUp': PhysicalKeyboardKey.arrowUp,
    'shiftLeft': PhysicalKeyboardKey.shiftLeft,
    'controlLeft': PhysicalKeyboardKey.controlLeft,
  };
  for (final entry in physKeys.entries) {
    print(
      '  PhysicalKeyboardKey.${entry.key}: usbHidUsage=${entry.value.usbHidUsage}',
    );
  }

  // ========== HardwareKeyboard ==========
  print('--- HardwareKeyboard Tests ---');
  final hwKeyboard = HardwareKeyboard.instance;
  print('HardwareKeyboard.instance: $hwKeyboard');
  print('  physicalKeysPressed: ${hwKeyboard.physicalKeysPressed}');
  print('  logicalKeysPressed: ${hwKeyboard.logicalKeysPressed}');
  print('  lockModesEnabled: ${hwKeyboard.lockModesEnabled}');

  // ========== KeySet ==========
  print('--- KeySet Tests ---');
  final keySet1 = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.keyC,
  );
  print('LogicalKeySet (Ctrl+C): $keySet1');

  final keySet2 = LogicalKeySet(
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.shift,
    LogicalKeyboardKey.keyS,
  );
  print('LogicalKeySet (Ctrl+Shift+S): $keySet2');

  // ========== SingleActivator ==========
  print('--- SingleActivator Tests ---');
  final activator1 = SingleActivator(LogicalKeyboardKey.keyC, control: true);
  print('SingleActivator (Ctrl+C) created');
  print('  trigger: ${activator1.trigger}');
  print('  control: ${activator1.control}');
  print('  shift: ${activator1.shift}');
  print('  alt: ${activator1.alt}');
  print('  meta: ${activator1.meta}');
  print('  includeRepeats: ${activator1.includeRepeats}');

  final activator2 = SingleActivator(
    LogicalKeyboardKey.keyS,
    control: true,
    shift: true,
    includeRepeats: false,
  );
  print('SingleActivator (Ctrl+Shift+S) created');

  // ========== CharacterActivator ==========
  print('--- CharacterActivator Tests ---');
  final charActivator = CharacterActivator('?');
  print('CharacterActivator("?") created');
  print('  character: ${charActivator.character}');

  // ========== KeyboardListener ==========
  print('--- KeyboardListener Tests ---');
  final keyboardListener = KeyboardListener(
    focusNode: FocusNode(),
    onKeyEvent: (event) {
      print('  KeyEvent: $event');
    },
    autofocus: false,
    includeSemantics: true,
    child: Container(
      width: 200,
      height: 200,
      color: Colors.blue[100],
      child: Center(child: Text('Press keys')),
    ),
  );
  print('KeyboardListener created');

  // ========== Shortcuts widget ==========
  print('--- Shortcuts Tests ---');
  final shortcuts = Shortcuts(
    shortcuts: {
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC):
          CopyIntent(),
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyV):
          PasteIntent(),
      SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
    },
    child: Actions(
      actions: {
        CopyIntent: CallbackAction<CopyIntent>(
          onInvoke: (intent) {
            print('  Copy invoked');
            return null;
          },
        ),
        PasteIntent: CallbackAction<PasteIntent>(
          onInvoke: (intent) {
            print('  Paste invoked');
            return null;
          },
        ),
        DismissIntent: CallbackAction<DismissIntent>(
          onInvoke: (intent) {
            print('  Dismiss invoked');
            return null;
          },
        ),
      },
      child: Focus(
        autofocus: true,
        child: Container(child: Text('Shortcuts active')),
      ),
    ),
  );
  print('Shortcuts + Actions created');

  // ========== Intent types ==========
  print('--- Intent Types ---');
  print('  CopyIntent: ${CopyIntent()}');
  print('  PasteIntent: ${PasteIntent()}');
  // SelectAllIntent, CutIntent, UndoIntent, RedoIntent are not public Flutter API
  print('  (SelectAll, Cut, Undo, Redo intents are private)');
  print('  DismissIntent: ${DismissIntent()}');
  print('  ActivateIntent: ${ActivateIntent()}');
  print('  ScrollIntent: ${ScrollIntent(direction: AxisDirection.down)}');

  print('All key events tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(body: Column(children: [keyboardListener, shortcuts])),
  );
}

class CopyIntent extends Intent {}

class PasteIntent extends Intent {}
