// DO NOT MODIFY - AUTO-GENERATED PRINT-ONLY TEST
// This file is a placeholder test that will be implemented manually.
// This test file uses a simplified single-class-value widget pattern for D4rt AST validation.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Print-only test for SingleActivator class.
/// Tests keyboard shortcut activator with print output verification.
class SingleActivatorTestApp extends StatelessWidget {
  const SingleActivatorTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SingleActivator Print Test',
      home: SingleActivatorTestPage(),
    );
  }
}

/// Test page demonstrating SingleActivator functionality via printed output.
class SingleActivatorTestPage extends StatefulWidget {
  const SingleActivatorTestPage({super.key});

  @override
  State<SingleActivatorTestPage> createState() => _SingleActivatorTestPageState();
}

class _SingleActivatorTestPageState extends State<SingleActivatorTestPage> {
  /// Test SingleActivator basic constructor
  void _testBasicConstructor() {
    print('=== SingleActivator Basic Constructor ===');
    const activator = SingleActivator(LogicalKeyboardKey.keyA);
    print('Created SingleActivator: $activator');
    print('Trigger: keyA');
    print('control: false (default)');
    print('shift: false (default)');
    print('alt: false (default)');
    print('meta: false (default)');
    print('includeRepeats: true (default)');
  }

  /// Test SingleActivator with control modifier
  void _testControlModifier() {
    print('=== SingleActivator Control Modifier ===');
    const activator = SingleActivator(LogicalKeyboardKey.keyC, control: true);
    print('Created: Ctrl+C');
    print('Trigger: keyC');
    print('control: true');
    print('Common use: Copy shortcut');
    
    const activatorV = SingleActivator(LogicalKeyboardKey.keyV, control: true);
    print('Created: Ctrl+V');
    print('Common use: Paste shortcut');
  }

  /// Test SingleActivator with shift modifier
  void _testShiftModifier() {
    print('=== SingleActivator Shift Modifier ===');
    const activator = SingleActivator(LogicalKeyboardKey.delete, shift: true);
    print('Created: Shift+Delete');
    print('Trigger: delete');
    print('shift: true');
    
    const activatorTab = SingleActivator(LogicalKeyboardKey.tab, shift: true);
    print('Created: Shift+Tab');
    print('Common use: Previous focus');
  }

  /// Test SingleActivator with alt modifier
  void _testAltModifier() {
    print('=== SingleActivator Alt Modifier ===');
    const activator = SingleActivator(LogicalKeyboardKey.f4, alt: true);
    print('Created: Alt+F4');
    print('Trigger: f4');
    print('alt: true');
    print('Common use: Close window (Windows)');
  }

  /// Test SingleActivator with meta modifier
  void _testMetaModifier() {
    print('=== SingleActivator Meta Modifier ===');
    const activator = SingleActivator(LogicalKeyboardKey.keyQ, meta: true);
    print('Created: Meta+Q (Cmd+Q on macOS)');
    print('Trigger: keyQ');
    print('meta: true');
    print('Common use: Quit application (macOS)');
  }

  /// Test SingleActivator with multiple modifiers
  void _testMultipleModifiers() {
    print('=== SingleActivator Multiple Modifiers ===');
    const activator = SingleActivator(
      LogicalKeyboardKey.keyA,
      control: true,
      alt: true,
      meta: true,
      shift: true,
    );
    print('Created: Control+Alt+Meta+Shift+A');
    print('All modifiers: true');
    print('Trigger: keyA');
  }

  /// Test SingleActivator includeRepeats property
  void _testIncludeRepeats() {
    print('=== SingleActivator includeRepeats ===');
    const activatorWithRepeats = SingleActivator(LogicalKeyboardKey.arrowDown, includeRepeats: true);
    print('With repeats: true');
    print('Triggers on held key repeats');
    
    const activatorNoRepeats = SingleActivator(LogicalKeyboardKey.space, includeRepeats: false);
    print('Without repeats: false');
    print('Only triggers on initial key down');
  }

  /// Test SingleActivator numLock property
  void _testNumLock() {
    print('=== SingleActivator NumLock ===');
    const activatorAny = SingleActivator(LogicalKeyboardKey.numpad1);
    print('Default numLock: LockState.ignored');
    print('Matches regardless of NumLock state');
    
    print('LockState.locked: requires NumLock on');
    print('LockState.unlocked: requires NumLock off');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SingleActivator Test')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(onPressed: _testBasicConstructor, child: const Text('Test Basic Constructor')),
            ElevatedButton(onPressed: _testControlModifier, child: const Text('Test Control Modifier')),
            ElevatedButton(onPressed: _testShiftModifier, child: const Text('Test Shift Modifier')),
            ElevatedButton(onPressed: _testAltModifier, child: const Text('Test Alt Modifier')),
            ElevatedButton(onPressed: _testMetaModifier, child: const Text('Test Meta Modifier')),
            ElevatedButton(onPressed: _testMultipleModifiers, child: const Text('Test Multiple Modifiers')),
            ElevatedButton(onPressed: _testIncludeRepeats, child: const Text('Test includeRepeats')),
            ElevatedButton(onPressed: _testNumLock, child: const Text('Test NumLock')),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const SingleActivatorTestApp());
}
