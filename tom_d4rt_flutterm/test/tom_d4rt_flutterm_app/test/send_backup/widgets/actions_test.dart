import 'package:flutter/material.dart';

class _IncrementIntent extends Intent {
  const _IncrementIntent();
}

class _IncrementAction extends Action<_IncrementIntent> {
  _IncrementAction(this.onInvoke);
  final VoidCallback onInvoke;

  @override
  Object? invoke(_IncrementIntent intent) {
    onInvoke();
    return null;
  }
}

dynamic build(BuildContext context) {
  return _ActionsDemo();
}

class _ActionsDemo extends StatefulWidget {
  @override
  State<_ActionsDemo> createState() => _ActionsDemoState();
}

class _ActionsDemoState extends State<_ActionsDemo> {
  var _value = 0;

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        _IncrementIntent: _IncrementAction(() => setState(() => _value++)),
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Actions demo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          FilledButton(
            onPressed: () => Actions.invoke(context, const _IncrementIntent()),
            child: const Text('Invoke intent'),
          ),
          Text('Current value: $_value'),
        ],
      ),
    );
  }
}
