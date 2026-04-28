// ignore_for_file: avoid_print
// D4rt test script: Tests ContextAction from widgets/actions.dart
// Deep Demo: Visual exploration of ContextAction — the Action subclass that
// receives a BuildContext when invoked, enabling context-aware decisions.
//
// ContextAction extends Action<T> and modifies the invoke() and isEnabled()
// signatures to include an optional BuildContext parameter. This is crucial
// when an action's behavior depends on the widget tree — reading theme data,
// checking ancestor state, accessing inherited widgets, or navigating.
//
// Regular Action.invoke(intent) has no idea WHERE in the tree it was triggered.
// ContextAction.invoke(intent, [context]) knows exactly where, because the
// ActionDispatcher passes the invocation context automatically.
//
// Scene 1 — Action System Architecture: visual pipeline from Intent to Action
// Scene 2 — Basic ContextAction: custom intent + action with visual feedback
// Scene 3 — Context-Aware Enable/Disable: isEnabled reads ancestor state
// Scene 4 — ContextAction vs Action: side-by-side comparison
// Scene 5 — Multiple ContextActions Gallery: theme-reading, tree-climbing
// Scene 6 — Practical Patterns: real-world context-aware action scenarios
import 'package:flutter/material.dart';

// ──────────────────────────────────────────────────────────
// Custom Intents for our demonstrations
// ──────────────────────────────────────────────────────────

/// A simple intent that carries a label describing what to do.
class LabeledIntent extends Intent {
  const LabeledIntent(this.label);
  final String label;
}

/// An intent for greeting that carries a name.
class GreetIntent extends Intent {
  const GreetIntent(this.name);
  final String name;
}

/// An intent for toggling a feature.
class ToggleIntent extends Intent {
  const ToggleIntent();
}

/// An intent for showing information.
class ShowInfoIntent extends Intent {
  const ShowInfoIntent();
}

/// An intent for a highlight action.
class HighlightIntent extends Intent {
  const HighlightIntent();
}

/// An intent for demonstrating tree-climbing.
class TreeClimbIntent extends Intent {
  const TreeClimbIntent();
}

/// An intent for reading theme data.
class ThemeReadIntent extends Intent {
  const ThemeReadIntent();
}

/// An intent for demonstrating a plain action (non-context).
class PlainActionIntent extends Intent {
  const PlainActionIntent();
}

// ──────────────────────────────────────────────────────────
// Custom ContextAction implementations
// ──────────────────────────────────────────────────────────

/// A ContextAction that uses the context to read the current text direction
/// and includes it in its greeting response.
class GreetContextAction extends ContextAction<GreetIntent> {
  String lastResult = '';

  @override
  Object? invoke(GreetIntent intent, [BuildContext? context]) {
    final direction = context != null ? Directionality.of(context) : null;
    final dirLabel = direction == TextDirection.ltr ? 'LTR' : 'RTL';
    lastResult = 'Hello, ${intent.name}! (Dir: $dirLabel)';
    print('  GreetContextAction invoked: $lastResult');
    return lastResult;
  }
}

/// A ContextAction that checks if an ancestor InheritedWidget provides
/// enablement state. If the nearest "enablement" says disabled, this
/// action refuses to invoke.
class ConditionalContextAction extends ContextAction<ToggleIntent> {
  bool wasInvoked = false;

  @override
  bool isEnabled(ToggleIntent intent, [BuildContext? context]) {
    // This demonstrates context-aware enabling:
    // A real implementation would check an InheritedWidget.
    // Here we check if context can find a Scaffold ancestor.
    if (context != null) {
      final scaffold = Scaffold.maybeOf(context);
      return scaffold != null;
    }
    return true;
  }

  @override
  Object? invoke(ToggleIntent intent, [BuildContext? context]) {
    wasInvoked = true;
    final hasScaffold = context != null && Scaffold.maybeOf(context) != null;
    print('  ConditionalContextAction invoked (scaffold: $hasScaffold)');
    return hasScaffold;
  }
}

/// A ContextAction that reads theme brightness from context.
class ThemeReadContextAction extends ContextAction<ThemeReadIntent> {
  String lastBrightness = 'unknown';

  @override
  Object? invoke(ThemeReadIntent intent, [BuildContext? context]) {
    if (context != null) {
      final theme = Theme.of(context);
      lastBrightness = theme.brightness == Brightness.dark ? 'dark' : 'light';
    } else {
      lastBrightness = 'no-context';
    }
    print('  ThemeReadContextAction: brightness=$lastBrightness');
    return lastBrightness;
  }
}

/// A ContextAction that walks up the tree to count how many Container
/// ancestors it has — demonstrating tree-climbing capability.
class TreeClimbContextAction extends ContextAction<TreeClimbIntent> {
  int ancestorCount = 0;

  @override
  Object? invoke(TreeClimbIntent intent, [BuildContext? context]) {
    ancestorCount = 0;
    if (context != null) {
      context.visitAncestorElements((element) {
        if (element.widget is Container) {
          ancestorCount++;
        }
        return true;
      });
    }
    print('  TreeClimbContextAction: found $ancestorCount Container ancestors');
    return ancestorCount;
  }
}

/// A plain Action (NOT ContextAction) for comparison — it has no BuildContext.
class PlainAction extends Action<PlainActionIntent> {
  String lastResult = '';

  @override
  Object? invoke(PlainActionIntent intent) {
    lastResult = 'Invoked without context';
    print('  PlainAction: $lastResult');
    return lastResult;
  }
}

dynamic build(BuildContext context) {
  print('ContextAction Deep Demo executing');
  print('=' * 60);

  // ──────────────────────────────────────────────────────────
  // Color palette — copper/navy/ivory action theme
  // ──────────────────────────────────────────────────────────
  const cCopper = Color(0xFFBF360C);      // deep copper - primary
  const cNavy = Color(0xFF1A237E);        // deep navy - secondary
  const cIvory = Color(0xFFFFFDE7);       // soft ivory - surface
  const cSlate = Color(0xFF37474F);       // blue-grey slate - text
  const cTeal = Color(0xFF00695C);        // teal - success/info
  const cPurple = Color(0xFF6A1B9A);      // purple - highlight
  const cAmber = Color(0xFFF57F17);       // deep amber - warning
  const cForest = Color(0xFF2E7D32);      // forest green - positive
  const cRose = Color(0xFFAD1457);        // rose - accent

  // ──────────────────────────────────────────────────────────
  // Helper builders
  // ──────────────────────────────────────────────────────────

  Widget sceneHeader(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 34.0, bottom: 14.0),
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.03)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: color, size: 24.0),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: color.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoBox(String text, Color color) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          color: cSlate.withValues(alpha: 0.85),
          height: 1.5,
        ),
      ),
    );
  }

  Widget codeSnippet(String code, Color borderColor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: cSlate.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: borderColor.withValues(alpha: 0.15)),
      ),
      child: Text(
        code,
        style: TextStyle(
          fontSize: 10.0,
          fontFamily: 'monospace',
          color: cSlate.withValues(alpha: 0.8),
          height: 1.4,
        ),
      ),
    );
  }

  Widget tagLabel(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget demoCard({
    required String title,
    required String description,
    required Widget child,
    required Color accent,
    double? width,
  }) {
    return Container(
      width: width ?? 300.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: 0.08),
            blurRadius: 8.0,
            offset: const Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.06),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(11.0),
                topRight: Radius.circular(11.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: accent,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: cSlate.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: child,
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // SCENE 1 — Action System Architecture
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 1: Action System Architecture ---');
  print('Visual pipeline: Intent → ActionDispatcher → ContextAction + context');

  Widget pipelineBox(String label, String detail, IconData icon, Color color) {
    return Container(
      width: 110.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 22.0),
          const SizedBox(height: 4.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 2.0),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9.0, color: color.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }

  final scene1 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 1 — Action System Architecture',
        'How Flutter routes Intents to ContextActions with BuildContext',
        Icons.account_tree,
        cCopper,
      ),
      infoBox(
        'Flutter\'s action system works as a pipeline: a user gesture or '
        'keyboard shortcut produces an Intent. The Actions widget maps that '
        'Intent to an Action. The ActionDispatcher invokes the Action. If '
        'the Action is a ContextAction, the dispatcher passes the '
        'BuildContext of the invocation site — enabling the action to read '
        'theme data, find ancestors, navigate, show dialogs, etc.',
        cCopper,
      ),

      // Pipeline diagram
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: cIvory,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: cCopper.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Text(
              'Intent → Action Pipeline',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: cCopper),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                pipelineBox('Intent', 'Describes WHAT\nto do', Icons.description, cNavy),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.arrow_forward, color: cSlate.withValues(alpha: 0.4), size: 18.0),
                ),
                pipelineBox('Actions\nWidget', 'Maps Intent\nto Action', Icons.map, cTeal),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.arrow_forward, color: cSlate.withValues(alpha: 0.4), size: 18.0),
                ),
                pipelineBox('Dispatcher', 'Invokes the\nAction', Icons.send, cAmber),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.arrow_forward, color: cSlate.withValues(alpha: 0.4), size: 18.0),
                ),
                pipelineBox('Context\nAction', 'Receives\nBuildContext!', Icons.location_on, cCopper),
              ],
            ),
            const SizedBox(height: 16.0),
            // The key difference callout
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cCopper.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cCopper.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.key, color: cCopper, size: 20.0),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Key Difference: Action.invoke(intent) gets no context.\n'
                      'ContextAction.invoke(intent, [context]) receives the '
                      'BuildContext of the invocation site!',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: cCopper,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Class hierarchy visualization
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cNavy.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Class Hierarchy',
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: cNavy),
            ),
            const SizedBox(height: 10.0),
            // Action base
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cNavy.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cNavy.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Action<T extends Intent>',
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cNavy, fontFamily: 'monospace'),
                  ),
                  Text(
                    'invoke(T intent) — no context available',
                    style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                  ),
                ],
              ),
            ),
            // Arrow down
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Column(
                children: [
                  Container(width: 2.0, height: 12.0, color: cSlate.withValues(alpha: 0.3)),
                  Icon(Icons.arrow_drop_down, color: cSlate.withValues(alpha: 0.5), size: 18.0),
                ],
              ),
            ),
            // ContextAction
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cCopper.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cCopper.withValues(alpha: 0.3), width: 2.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.star, color: cCopper, size: 16.0),
                      const SizedBox(width: 6.0),
                      Text(
                        'ContextAction<T extends Intent>',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cCopper, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                  Text(
                    'invoke(T intent, [BuildContext? context])',
                    style: TextStyle(fontSize: 10.0, color: cCopper.withValues(alpha: 0.8), fontFamily: 'monospace'),
                  ),
                  Text(
                    'isEnabled(T intent, [BuildContext? context])',
                    style: TextStyle(fontSize: 10.0, color: cCopper.withValues(alpha: 0.8), fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '↑ Both methods receive the BuildContext from the invocation site!',
                    style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: cCopper),
                  ),
                ],
              ),
            ),
            // Two children branches
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 4.0),
              child: Row(
                children: [
                  // CallbackAction branch
                  Column(
                    children: [
                      Container(width: 2.0, height: 8.0, color: cSlate.withValues(alpha: 0.2)),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: cTeal.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: cTeal.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          'CallbackAction\n(extends Action)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9.0, color: cTeal),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    children: [
                      Container(width: 2.0, height: 8.0, color: cSlate.withValues(alpha: 0.2)),
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: cPurple.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: cPurple.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          'YourContextAction\n(extends ContextAction)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 9.0, color: cPurple),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      codeSnippet(
        'abstract class ContextAction<T extends Intent> extends Action<T> {\n'
        '  @override\n'
        '  bool isEnabled(T intent, [BuildContext? context]);\n'
        '\n'
        '  @override\n'
        '  Object? invoke(T intent, [BuildContext? context]);\n'
        '}',
        cCopper,
      ),
    ],
  );

  print('Scene 1 built: action system pipeline + class hierarchy');

  // ════════════════════════════════════════════════════════════
  // SCENE 2 — Basic ContextAction in Practice
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 2: Basic ContextAction in Practice ---');
  print('Custom Intent + ContextAction wired via Actions widget');

  final greetAction = GreetContextAction();

  final scene2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 2 — Basic ContextAction in Practice',
        'Wiring a custom ContextAction via the Actions widget',
        Icons.play_circle_outline,
        cNavy,
      ),
      infoBox(
        'To use a ContextAction: (1) define an Intent subclass describing the '
        'operation, (2) create a ContextAction subclass that overrides invoke() '
        'with the optional BuildContext parameter, (3) register it in an '
        'Actions widget mapping the Intent type to the ContextAction instance.',
        cNavy,
      ),

      // Step-by-step implementation
      demoCard(
        title: 'Step 1 — Define the Intent',
        description: 'An Intent carries the request data',
        accent: cNavy,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            codeSnippet(
              'class GreetIntent extends Intent {\n'
              '  const GreetIntent(this.name);\n'
              '  final String name;\n'
              '}',
              cNavy,
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                tagLabel('immutable', cNavy),
                const SizedBox(width: 6.0),
                tagLabel('const-capable', cTeal),
                const SizedBox(width: 6.0),
                tagLabel('carries data', cAmber),
              ],
            ),
          ],
        ),
      ),

      demoCard(
        title: 'Step 2 — Implement the ContextAction',
        description: 'The action receives BuildContext on invoke',
        accent: cCopper,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            codeSnippet(
              'class GreetContextAction extends ContextAction<GreetIntent> {\n'
              '  @override\n'
              '  Object? invoke(GreetIntent intent, [BuildContext? context]) {\n'
              '    final dir = context != null\n'
              '      ? Directionality.of(context)  // <-- uses context!\n'
              '      : null;\n'
              '    return "Hello, \${intent.name}! (Dir: \$dir)";\n'
              '  }\n'
              '}',
              cCopper,
            ),
            const SizedBox(height: 6.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: cCopper.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Row(
                children: [
                  Icon(Icons.lightbulb_outline, color: cCopper, size: 16.0),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(
                      'The context lets us call Directionality.of(context), '
                      'Theme.of(context), MediaQuery.of(context), etc.',
                      style: TextStyle(fontSize: 10.0, color: cCopper),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      demoCard(
        title: 'Step 3 — Wire with Actions widget',
        description: 'Register the mapping and invoke via Actions.invoke()',
        accent: cTeal,
        width: 380.0,
        child: Actions(
          actions: <Type, Action<Intent>>{
            GreetIntent: greetAction,
          },
          child: Builder(
            builder: (innerContext) {
              // D4RT-LIMITATION #8: Actions.invoke type-keyed dispatch does not
              // work for user-defined Intent subclasses — call directly instead.
              final result = greetAction.invoke(
                const GreetIntent('Flutter Developer'),
                innerContext,
              );
              print('  Greet action result: $result');

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  codeSnippet(
                    'Actions(\n'
                    '  actions: { GreetIntent: GreetContextAction() },\n'
                    '  child: Builder(builder: (ctx) {\n'
                    '    final result = Actions.invoke<GreetIntent>(\n'
                    '      ctx, GreetIntent("Flutter Developer"));\n'
                    '    ...\n'
                    '  }),\n'
                    ')',
                    cTeal,
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: cForest.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cForest.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: cForest, size: 20.0),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            'Result: ${greetAction.lastResult}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: cForest,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ],
  );

  print('Scene 2 built: 3-step wiring guide with live action invocation');

  // ════════════════════════════════════════════════════════════
  // SCENE 3 — Context-Aware Enable/Disable
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 3: Context-Aware Enable/Disable ---');
  print('Using isEnabled with BuildContext to check ancestor presence');

  final conditionalAction = ConditionalContextAction();

  final scene3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 3 — Context-Aware Enable/Disable',
        'isEnabled() uses BuildContext to check if the action should run',
        Icons.toggle_on_outlined,
        cTeal,
      ),
      infoBox(
        'ContextAction.isEnabled(intent, [context]) is called by the '
        'ActionDispatcher before invoking the action. If it returns false, '
        'the action is skipped. Unlike regular Action.isEnabled(), the '
        'ContextAction version receives the BuildContext — so it can check '
        'ancestor widgets to decide whether the action is appropriate.',
        cTeal,
      ),

      // Demo: isEnabled checking for Scaffold ancestor
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // WITH Scaffold — action enabled
          demoCard(
            title: 'With Scaffold Ancestor',
            description: 'isEnabled checks Scaffold.maybeOf(context)',
            accent: cForest,
            width: 250.0,
            child: Actions(
              actions: <Type, Action<Intent>>{
                ToggleIntent: conditionalAction,
              },
              child: Builder(
                builder: (innerContext) {
                  // Inside a Scaffold, so isEnabled should be true
                  final enabled = conditionalAction.isEnabled(
                    const ToggleIntent(),
                    innerContext,
                  );
                  print('  ConditionalAction enabled (w/Scaffold): $enabled');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            enabled ? Icons.check_circle : Icons.cancel,
                            color: enabled ? cForest : cRose,
                            size: 24.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            enabled ? 'ENABLED' : 'DISABLED',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: enabled ? cForest : cRose,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Scaffold.maybeOf(context) found a Scaffold '
                        'ancestor → action is enabled.',
                        style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: double.infinity,
                        height: 40.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [cForest.withValues(alpha: 0.1), cForest.withValues(alpha: 0.2)],
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: cForest.withValues(alpha: 0.4)),
                        ),
                        child: Center(
                          child: Text(
                            'Action can be invoked ✓',
                            style: TextStyle(fontSize: 11.0, color: cForest, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // WITHOUT Scaffold — conceptual disabled state
          demoCard(
            title: 'Without Scaffold Ancestor',
            description: 'isEnabled returns false when no Scaffold found',
            accent: cRose,
            width: 250.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.cancel, color: cRose, size: 24.0),
                    const SizedBox(width: 8.0),
                    Text(
                      'DISABLED',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: cRose,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  'Without a Scaffold above in the tree, '
                  'Scaffold.maybeOf(context) returns null '
                  '→ action reports disabled.',
                  style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                ),
                const SizedBox(height: 6.0),
                Container(
                  width: double.infinity,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: cRose.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cRose.withValues(alpha: 0.3)),
                  ),
                  child: Center(
                    child: Text(
                      'Action blocked ✗',
                      style: TextStyle(fontSize: 11.0, color: cRose, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      const SizedBox(height: 8.0),
      codeSnippet(
        'class ConditionalContextAction extends ContextAction<ToggleIntent> {\n'
        '  @override\n'
        '  bool isEnabled(ToggleIntent intent, [BuildContext? context]) {\n'
        '    // Context-aware check: need a Scaffold ancestor\n'
        '    if (context != null) {\n'
        '      return Scaffold.maybeOf(context) != null;\n'
        '    }\n'
        '    return true;  // default when no context\n'
        '  }\n'
        '}',
        cTeal,
      ),
      infoBox(
        'This pattern is powerful for feature gating: an action can check for '
        'required ancestors (Scaffold, NavigatorState, FormState) before '
        'allowing invocation. Without ContextAction, you would need to check '
        'these conditions externally.',
        cForest,
      ),
    ],
  );

  print('Scene 3 built: enabled/disabled comparison with ancestor checks');

  // ════════════════════════════════════════════════════════════
  // SCENE 4 — ContextAction vs Action Comparison
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 4: ContextAction vs Action Comparison ---');
  print('Side-by-side to show what context access enables');

  final plainAction = PlainAction();
  // D4RT-LIMITATION #8: extract action before the widget tree so Actions.find
  // (type-keyed) can be replaced with a direct variable reference.
  final ctxCompareAction = GreetContextAction();

  final scene4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 4 — ContextAction vs Action',
        'Direct side-by-side showing the context advantage',
        Icons.compare_arrows,
        cPurple,
      ),
      infoBox(
        'A regular Action can only work with the data in the Intent itself. '
        'A ContextAction can additionally access the entire widget tree above '
        'the invocation point — theme, media query, localization, navigation, '
        'inherited widgets, and more.',
        cPurple,
      ),

      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Plain Action (no context)
          demoCard(
            title: 'Regular Action',
            description: 'invoke(intent) — no tree access',
            accent: cSlate,
            width: 260.0,
            child: Actions(
              actions: <Type, Action<Intent>>{
                PlainActionIntent: plainAction,
              },
              child: Builder(
                builder: (innerContext) {
                  // D4RT-LIMITATION #8: Actions.invoke type-keyed dispatch —
                  // call directly on the action instance instead.
                  final result = plainAction.invoke(const PlainActionIntent());
                  print('  PlainAction result: $result');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: cSlate.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: cSlate.withValues(alpha: 0.15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Can access:',
                              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cSlate),
                            ),
                            const SizedBox(height: 4.0),
                            Row(
                              children: [
                                Icon(Icons.check, color: cForest, size: 14.0),
                                const SizedBox(width: 4.0),
                                Text('Intent data', style: TextStyle(fontSize: 10.0, color: cSlate)),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.check, color: cForest, size: 14.0),
                                const SizedBox(width: 4.0),
                                Text('Action instance state', style: TextStyle(fontSize: 10.0, color: cSlate)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: cRose.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: cRose.withValues(alpha: 0.15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cannot access:',
                              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cRose),
                            ),
                            const SizedBox(height: 4.0),
                            for (final item in ['Theme', 'MediaQuery', 'Navigator', 'Scaffold', 'Localizations', 'Directionality'])
                              Row(
                                children: [
                                  Icon(Icons.close, color: cRose, size: 14.0),
                                  const SizedBox(width: 4.0),
                                  Text(item, style: TextStyle(fontSize: 10.0, color: cSlate)),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: double.infinity,
                        height: 36.0,
                        decoration: BoxDecoration(
                          color: cSlate.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Center(
                          child: Text(
                            plainAction.lastResult,
                            style: TextStyle(fontSize: 10.0, color: cSlate, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),

          // ContextAction (with context)
          demoCard(
            title: 'ContextAction',
            description: 'invoke(intent, [context]) — full tree access',
            accent: cCopper,
            width: 260.0,
            child: Actions(
              actions: <Type, Action<Intent>>{
                GreetIntent: ctxCompareAction,
              },
              child: Builder(
                builder: (innerContext) {
                  // D4RT-LIMITATION #8: Actions.find/invoke type-keyed dispatch
                  // does not work — use extracted variable directly instead.
                  final action = ctxCompareAction;
                  final result = ctxCompareAction.invoke(
                    const GreetIntent('Copilot'),
                    innerContext,
                  );
                  print('  ContextAction comparison result: $result');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: cForest.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: cForest.withValues(alpha: 0.15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Can access:',
                              style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: cForest),
                            ),
                            const SizedBox(height: 4.0),
                            for (final item in ['Intent data', 'Action instance state', 'Theme', 'MediaQuery', 'Navigator', 'Scaffold', 'Localizations', 'Directionality', 'Any InheritedWidget!'])
                              Row(
                                children: [
                                  Icon(Icons.check, color: cForest, size: 14.0),
                                  const SizedBox(width: 4.0),
                                  Flexible(
                                    child: Text(item, style: TextStyle(fontSize: 10.0, color: cSlate)),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: double.infinity,
                        height: 36.0,
                        decoration: BoxDecoration(
                          color: cCopper.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(color: cCopper.withValues(alpha: 0.2)),
                        ),
                        child: Center(
                          child: Text(
                            'Type: ${action.runtimeType}',
                            style: TextStyle(fontSize: 10.0, color: cCopper, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ],
  );

  print('Scene 4 built: Action vs ContextAction side-by-side');

  // ════════════════════════════════════════════════════════════
  // SCENE 5 — Multiple ContextActions Gallery
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 5: Multiple ContextActions Gallery ---');
  print('Different ContextAction implementations using context differently');

  final themeAction = ThemeReadContextAction();
  final treeClimbAction = TreeClimbContextAction();
  // D4RT-LIMITATION #8: extract action instances before the widget tree so
  // Actions.find (type-keyed) can be replaced with direct variable references.
  final ltrGreetAction = GreetContextAction();
  final rtlGreetAction = GreetContextAction();

  final scene5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 5 — Multiple ContextActions Gallery',
        'Different ways ContextActions use the BuildContext',
        Icons.auto_awesome_mosaic,
        cAmber,
      ),
      infoBox(
        'The BuildContext passed to ContextAction can be used for many purposes: '
        'reading theme data, counting ancestors, checking text direction, '
        'accessing media queries, finding specific widgets in the tree, and more. '
        'Here are several specialized ContextActions demonstrating the variety.',
        cAmber,
      ),

      // Theme-reading action
      demoCard(
        title: 'Theme Reader Action',
        description: 'Reads brightness from Theme.of(context)',
        accent: cPurple,
        width: 380.0,
        child: Actions(
          actions: <Type, Action<Intent>>{
            ThemeReadIntent: themeAction,
          },
          child: Builder(
            builder: (innerContext) {
              // D4RT-LIMITATION #8: Actions.invoke type-keyed dispatch — call directly.
              themeAction.invoke(const ThemeReadIntent(), innerContext);

              return Row(
                children: [
                  Icon(Icons.brightness_6, color: cPurple, size: 28.0),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Detected brightness: ${themeAction.lastBrightness}',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: cPurple,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Action used Theme.of(context) to read the current '
                          'brightness setting. A regular Action could not do this '
                          'without the context parameter.',
                          style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: themeAction.lastBrightness == 'dark'
                          ? cSlate
                          : cIvory,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cPurple.withValues(alpha: 0.3)),
                    ),
                    child: Center(
                      child: Icon(
                        themeAction.lastBrightness == 'dark'
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: themeAction.lastBrightness == 'dark'
                            ? cIvory
                            : cAmber,
                        size: 24.0,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),

      // Tree-climbing action
      demoCard(
        title: 'Tree Climber Action',
        description: 'Uses visitAncestorElements to count Container ancestors',
        accent: cForest,
        width: 380.0,
        child: Container(
          // container 1
          padding: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            border: Border.all(color: cForest.withValues(alpha: 0.15)),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Container(
            // container 2
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              border: Border.all(color: cForest.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Container(
              // container 3
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                border: Border.all(color: cForest.withValues(alpha: 0.25)),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Actions(
                actions: <Type, Action<Intent>>{
                  TreeClimbIntent: treeClimbAction,
                },
                child: Builder(
                  builder: (innerContext) {
                    // D4RT-LIMITATION #8: Actions.invoke type-keyed dispatch — call directly.
                    treeClimbAction.invoke(const TreeClimbIntent(), innerContext);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.account_tree, color: cForest, size: 24.0),
                            const SizedBox(width: 8.0),
                            Text(
                              'Found ${treeClimbAction.ancestorCount} Container ancestors',
                              style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: cForest,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Text(
                          'The action used context.visitAncestorElements() '
                          'to walk up the widget tree and count how many '
                          'Container widgets are above it. This is a nested '
                          '3-Container structure, so the count includes those '
                          'plus any Container widgets from the demoCard wrapper '
                          'and outer layout.',
                          style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
                        ),
                        const SizedBox(height: 6.0),
                        // Visual nesting representation
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                cForest.withValues(alpha: 0.05),
                                cForest.withValues(alpha: 0.15),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (var i = 0; i < 3; i++)
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                  width: 30.0,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                    color: cForest.withValues(alpha: 0.1 + i * 0.1),
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(color: cForest),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${i + 1}',
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: cForest,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(width: 6.0),
                              Text(
                                '← 3 local nesting levels',
                                style: TextStyle(fontSize: 10.0, color: cForest),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),

      // Directionality-reading action (reusing GreetContextAction)
      demoCard(
        title: 'Directionality Reader Action',
        description: 'Reads text direction from Directionality.of(context)',
        accent: cNavy,
        width: 380.0,
        child: Row(
          children: [
            // LTR context
            Expanded(
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Actions(
                  actions: <Type, Action<Intent>>{
                    GreetIntent: ltrGreetAction,
                  },
                  child: Builder(
                    builder: (innerContext) {
                      // D4RT-LIMITATION #8: Actions.find/invoke type-keyed dispatch
                      // does not work — use extracted variables directly instead.
                      final action = ltrGreetAction;
                      ltrGreetAction.invoke(const GreetIntent('LTR User'), innerContext);
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: cNavy.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: cNavy.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.format_textdirection_l_to_r, color: cNavy, size: 24.0),
                            const SizedBox(height: 4.0),
                            Text(
                              'LTR Context',
                              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cNavy),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              action.lastResult,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.7)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // RTL context
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Actions(
                  actions: <Type, Action<Intent>>{
                    GreetIntent: rtlGreetAction,
                  },
                  child: Builder(
                    builder: (innerContext) {
                      // D4RT-LIMITATION #8: Actions.find/invoke type-keyed dispatch
                      // does not work — use extracted variables directly instead.
                      final action = rtlGreetAction;
                      rtlGreetAction.invoke(const GreetIntent('RTL User'), innerContext);
                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: cRose.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: cRose.withValues(alpha: 0.2)),
                        ),
                        child: Column(
                          children: [
                            Icon(Icons.format_textdirection_r_to_l, color: cRose, size: 24.0),
                            const SizedBox(height: 4.0),
                            Text(
                              'RTL Context',
                              style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cRose),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              action.lastResult,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.7)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 4.0),
      infoBox(
        'Each ContextAction uses the BuildContext differently:\n'
        '• ThemeReader calls Theme.of(context) for brightness\n'
        '• TreeClimber uses context.visitAncestorElements() for tree walking\n'
        '• GreetAction uses Directionality.of(context) for text direction\n\n'
        'All three demonstrate the core ContextAction advantage: '
        'actions that are aware of their surroundings.',
        cAmber,
      ),
    ],
  );

  print('Scene 5 built: 3 specialized ContextActions with live invocations');

  // ════════════════════════════════════════════════════════════
  // SCENE 6 — Practical Patterns
  // ════════════════════════════════════════════════════════════
  print('\n--- Scene 6: Practical Patterns ---');
  print('Real-world ContextAction usage scenarios');

  // D4RT-LIMITATION #8: extract action before the widget tree so Actions.invoke
  // (type-keyed) can be replaced with a direct variable reference.
  final showInfoAction = _ShowInfoContextAction();

  final scene6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      sceneHeader(
        'Scene 6 — Practical Patterns',
        'Real-world scenarios where ContextAction outshines regular Action',
        Icons.build_circle,
        cForest,
      ),
      infoBox(
        'ContextAction is not just a theoretical nicety — it solves real '
        'problems. Here are common patterns where having the BuildContext '
        'in your action makes all the difference.',
        cForest,
      ),

      // Pattern 1: Theme-aware formatting
      demoCard(
        title: 'Pattern: Theme-Aware Formatting',
        description: 'Action adjusts output based on current theme',
        accent: cPurple,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Light theme
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cPurple.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.light_mode, color: cAmber, size: 22.0),
                        const SizedBox(height: 4.0),
                        Text(
                          'Light Mode',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cSlate),
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                          width: double.infinity,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: cPurple.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              'Dark text on light bg',
                              style: TextStyle(fontSize: 9.0, color: cSlate),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                // Dark theme
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: cSlate,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cPurple.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.dark_mode, color: cIvory, size: 22.0),
                        const SizedBox(height: 4.0),
                        Text(
                          'Dark Mode',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cIvory),
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                          width: double.infinity,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: cPurple.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              'Light text on dark bg',
                              style: TextStyle(fontSize: 9.0, color: cIvory),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'A ContextAction can read Theme.of(context).brightness to '
              'choose different formatting for light vs dark mode — without '
              'the caller needing to pass theme data in the Intent.',
              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),

      // Pattern 2: Ancestor-gated action
      demoCard(
        title: 'Pattern: Ancestor-Gated Action',
        description: 'Action checks for required ancestor before executing',
        accent: cTeal,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cTeal.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: cTeal.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security, color: cTeal, size: 20.0),
                      const SizedBox(width: 8.0),
                      Text(
                        'Gate Conditions',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: cTeal),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  for (final gate in [
                    {'check': 'Scaffold.maybeOf(context)', 'purpose': 'Needs scaffold for snackbar'},
                    {'check': 'Navigator.maybeOf(context)', 'purpose': 'Needs navigator for routing'},
                    {'check': 'Form.maybeOf(context)', 'purpose': 'Needs form for validation'},
                    {'check': 'Overlay.maybeOf(context)', 'purpose': 'Needs overlay for popups'},
                  ])
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: BoxDecoration(
                              color: cTeal,
                              borderRadius: BorderRadius.circular(3.0),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              '${gate['check']} → ${gate['purpose']}',
                              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.7), fontFamily: 'monospace'),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            codeSnippet(
              '@override\n'
              'bool isEnabled(MyIntent intent, [BuildContext? context]) {\n'
              '  if (context == null) return false;\n'
              '  // Only enable if we have the ancestors we need\n'
              '  return Navigator.maybeOf(context) != null\n'
              '      && Scaffold.maybeOf(context) != null;\n'
              '}',
              cTeal,
            ),
          ],
        ),
      ),

      // Pattern 3: MediaQuery-responsive action
      demoCard(
        title: 'Pattern: Screen-Size-Aware Action',
        description: 'Action behavior changes based on screen dimensions',
        accent: cAmber,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Phone
                Container(
                  width: 70.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                    color: cAmber.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cAmber.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone_android, color: cAmber, size: 20.0),
                      const SizedBox(height: 4.0),
                      Text('Phone', style: TextStyle(fontSize: 9.0, color: cAmber, fontWeight: FontWeight.bold)),
                      Text('Bottom\nSheet', textAlign: TextAlign.center, style: TextStyle(fontSize: 8.0, color: cSlate.withValues(alpha: 0.5))),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                // Tablet
                Container(
                  width: 120.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: cTeal.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cTeal.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.tablet, color: cTeal, size: 20.0),
                      const SizedBox(height: 4.0),
                      Text('Tablet', style: TextStyle(fontSize: 9.0, color: cTeal, fontWeight: FontWeight.bold)),
                      Text('Side Panel', textAlign: TextAlign.center, style: TextStyle(fontSize: 8.0, color: cSlate.withValues(alpha: 0.5))),
                    ],
                  ),
                ),
                const SizedBox(width: 8.0),
                // Desktop
                Container(
                  width: 150.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: cNavy.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: cNavy.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.desktop_windows, color: cNavy, size: 20.0),
                      const SizedBox(height: 4.0),
                      Text('Desktop', style: TextStyle(fontSize: 9.0, color: cNavy, fontWeight: FontWeight.bold)),
                      Text('Dialog', textAlign: TextAlign.center, style: TextStyle(fontSize: 8.0, color: cSlate.withValues(alpha: 0.5))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              'A ContextAction can read MediaQuery.sizeOf(context) in invoke() to '
              'show a bottom sheet on phone, a side panel on tablet, or a dialog '
              'on desktop — all from the same Intent mapping.',
              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
            ),
            const SizedBox(height: 6.0),
            codeSnippet(
              '@override\n'
              'Object? invoke(ShowIntent intent, [BuildContext? context]) {\n'
              '  if (context == null) return null;\n'
              '  final width = MediaQuery.sizeOf(context).width;\n'
              '  if (width < 600) showBottomSheet(...);\n'
              '  else if (width < 1024) showSidePanel(...);\n'
              '  else showDialog(...);\n'
              '}',
              cAmber,
            ),
          ],
        ),
      ),

      // Pattern 4: Nested Actions overriding
      demoCard(
        title: 'Pattern: Action Overriding Chain',
        description: 'Nested Actions widgets override ancestor mappings',
        accent: cRose,
        width: 380.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual nesting of Actions widgets
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: cRose.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: cRose.withValues(alpha: 0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      tagLabel('Outer Actions', cNavy),
                      const SizedBox(width: 6.0),
                      Text(
                        'GreetIntent → DefaultGreetAction',
                        style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.5), fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: cRose.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cRose.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            tagLabel('Inner Actions', cRose),
                            const SizedBox(width: 6.0),
                            Text(
                              'GreetIntent → SpecialGreetAction',
                              style: TextStyle(fontSize: 9.0, color: cSlate.withValues(alpha: 0.5), fontFamily: 'monospace'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          width: double.infinity,
                          height: 40.0,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [cRose.withValues(alpha: 0.08), cRose.withValues(alpha: 0.15)],
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Center(
                            child: Text(
                              'invoke() here → uses SpecialGreetAction (inner wins!)',
                              style: TextStyle(fontSize: 10.0, color: cRose, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'When nested Actions widgets both map the same Intent type, the '
              'innermost one wins. With ContextAction, the inner action still '
              'has full context access — it can even find the OUTER action via '
              'context and delegate to it (using Action.callingAction).',
              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.6)),
            ),
          ],
        ),
      ),

      // Pattern 5: Live Actions.invoke demonstration
      demoCard(
        title: 'Pattern: Live Actions.invoke Demonstration',
        description: 'Actions.invoke passes context to ContextAction automatically',
        accent: cCopper,
        width: 380.0,
        child: Actions(
          actions: <Type, Action<Intent>>{
            ShowInfoIntent: showInfoAction,
          },
          child: Builder(
            builder: (innerContext) {
              // D4RT-LIMITATION #8: Actions.invoke type-keyed dispatch — call directly.
              final result = showInfoAction.invoke(const ShowInfoIntent(), innerContext);
              print('  ShowInfoContextAction result: $result');

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: cCopper.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cCopper.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Actions.invoke() automatically:',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: cCopper),
                        ),
                        const SizedBox(height: 6.0),
                        for (final step in [
                          '1. Finds the nearest Actions ancestor',
                          '2. Looks up the Intent → Action mapping',
                          '3. Checks if action is ContextAction',
                          '4. If yes, passes BuildContext to invoke()',
                          '5. If no, calls invoke() without context',
                        ])
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text(
                              step,
                              style: TextStyle(fontSize: 10.0, color: cSlate.withValues(alpha: 0.7)),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    height: 40.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [cForest.withValues(alpha: 0.1), cForest.withValues(alpha: 0.2)],
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: cForest.withValues(alpha: 0.3)),
                    ),
                    child: Center(
                      child: Text(
                        'Result: ${result ?? "null"}',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: cForest,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      const SizedBox(height: 10.0),

      // Closing summary
      Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [cCopper.withValues(alpha: 0.08), cNavy.withValues(alpha: 0.06)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: cCopper.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.lightbulb_outline, color: cCopper, size: 18.0),
                const SizedBox(width: 8.0),
                Text(
                  'When to use ContextAction over Action',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: cCopper,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              '• Your action needs to read Theme, MediaQuery, or Localizations\n'
              '• Your action needs to show a SnackBar, Dialog, or BottomSheet\n'
              '• Your action needs to navigate via Navigator.of(context)\n'
              '• Your isEnabled() depends on ancestor widget presence\n'
              '• Your action behavior varies by screen size or orientation\n'
              '• Your action needs to access InheritedWidgets in the tree\n'
              '• Your action needs to walk or inspect the widget tree\n\n'
              'Use regular Action when the action only needs the Intent data '
              'and its own instance state — no tree access required.',
              style: TextStyle(
                fontSize: 11.0,
                color: cSlate.withValues(alpha: 0.8),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  print('Scene 6 built: 5 practical patterns with live demonstrations');

  // ════════════════════════════════════════════════════════════
  // TITLE BANNER
  // ════════════════════════════════════════════════════════════
  final titleBanner = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cCopper.withValues(alpha: 0.12), cNavy.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: cCopper.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.flash_on, color: cCopper, size: 28.0),
            const SizedBox(width: 10.0),
            Text(
              'ContextAction',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: cCopper,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(
          'Context-Aware Actions for the Flutter Widget Tree',
          style: TextStyle(
            fontSize: 13.0,
            color: cSlate.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 6.0,
          alignment: WrapAlignment.center,
          children: [
            tagLabel('ContextAction<T>', cCopper),
            tagLabel('invoke(intent, [context])', cNavy),
            tagLabel('isEnabled(intent, [context])', cTeal),
            tagLabel('Actions widget', cPurple),
            tagLabel('Intent → Action mapping', cAmber),
            tagLabel('BuildContext access', cForest),
          ],
        ),
      ],
    ),
  );

  // ════════════════════════════════════════════════════════════
  // ASSEMBLE APP
  // ════════════════════════════════════════════════════════════
  print('\n=== Assembling final layout ===');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: cIvory,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleBanner,
            scene1,
            scene2,
            scene3,
            scene4,
            scene5,
            scene6,
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    ),
  );
}

/// A ContextAction used in Scene 6 that reports what it knows about the context.
class _ShowInfoContextAction extends ContextAction<ShowInfoIntent> {
  @override
  Object? invoke(ShowInfoIntent intent, [BuildContext? context]) {
    if (context == null) return 'No context provided';
    final hasScaffold = Scaffold.maybeOf(context) != null;
    final direction = Directionality.of(context);
    final info = 'scaffold=$hasScaffold, dir=$direction';
    print('  _ShowInfoContextAction: $info');
    return info;
  }
}
