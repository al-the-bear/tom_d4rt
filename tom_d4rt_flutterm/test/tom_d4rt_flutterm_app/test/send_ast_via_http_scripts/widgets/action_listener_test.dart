import 'package:flutter/material.dart';

class _ListenerIntent extends Intent {
  const _ListenerIntent();
}

class _ListenerAction extends Action<_ListenerIntent> {
  _ListenerAction(this.onInvoke);
  final VoidCallback onInvoke;

  @override
  Object? invoke(_ListenerIntent intent) {
    onInvoke();
    return null;
  }
}

dynamic build(BuildContext context) {
  return _ActionListenerDemo();
}

class _ActionListenerDemo extends StatefulWidget {
  @override
  State<_ActionListenerDemo> createState() => _ActionListenerDemoState();
}

class _ActionListenerDemoState extends State<_ActionListenerDemo> {
  var _hits = 0;

  @override
  Widget build(BuildContext context) {
    final listenerAction = _ListenerAction(() => setState(() => _hits++));
    return Actions(
      actions: <Type, Action<Intent>>{_ListenerIntent: listenerAction},
      child: ActionListener(
        action: listenerAction,
        listener: (action) {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('ActionListener demo', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => Actions.invoke(context, const _ListenerIntent()),
              child: const Text('Invoke action'),
            ),
            Text('Hits: $_hits'),
          ],
        ),
      ),
    );
  }
}
