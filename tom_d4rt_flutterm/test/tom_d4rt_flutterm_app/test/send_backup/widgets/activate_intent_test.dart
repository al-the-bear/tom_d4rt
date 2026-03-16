import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  return Shortcuts(
    shortcuts: const <ShortcutActivator, Intent>{
      SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
      SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
    },
    child: Focus(
      autofocus: true,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ActivateIntent demo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Enter/Space mapped to ActivateIntent'),
        ],
      ),
    ),
  );
}
