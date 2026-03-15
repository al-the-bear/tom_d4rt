import 'package:flutter/material.dart';

class _ConcreteActivateAction extends ActivateAction {
  @override
  Object? invoke(covariant ActivateIntent intent) {
    return null;
  }
}

dynamic build(BuildContext context) {
  return Actions(
    actions: <Type, Action<Intent>>{ActivateIntent: _ConcreteActivateAction()},
    child: Focus(
      autofocus: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ActivateAction demo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text('Press Enter/Space while button has focus'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Focusable button'),
          ),
        ],
      ),
    ),
  );
}
