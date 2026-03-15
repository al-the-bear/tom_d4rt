import 'package:flutter/material.dart';

class _PingIntent extends Intent {
  const _PingIntent();
}

class _PingAction extends Action<_PingIntent> {
  _PingAction(this.onInvoke);
  final VoidCallback onInvoke;

  @override
  Object? invoke(_PingIntent intent) {
    onInvoke();
    return null;
  }
}

dynamic build(BuildContext context) {
  return _ActionDispatcherDemo();
}

class _ActionDispatcherDemo extends StatefulWidget {
  @override
  State<_ActionDispatcherDemo> createState() => _ActionDispatcherDemoState();
}

class _ActionDispatcherDemoState extends State<_ActionDispatcherDemo> {
  var _count = 0;

  @override
  Widget build(BuildContext context) {
    return Actions(
      dispatcher: ActionDispatcher(),
      actions: <Type, Action<Intent>>{_PingIntent: _PingAction(() => setState(() => _count++))},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('ActionDispatcher demo', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: () => Actions.invoke(context, const _PingIntent()),
            child: const Text('Dispatch action'),
          ),
          Text('Dispatch count: $_count'),
        ],
      ),
    );
  }
}
