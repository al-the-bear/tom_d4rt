import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  return Shortcuts(
    shortcuts: <ShortcutActivator, Intent>{
      const SingleActivator(LogicalKeyboardKey.arrowRight):
          const NextFocusIntent(),
      const SingleActivator(LogicalKeyboardKey.arrowLeft):
          const PreviousFocusIntent(),
    },
    child: Focus(
      autofocus: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Actions + Intents demo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 120,
                child: TextField(
                  decoration: InputDecoration(labelText: 'Field A'),
                ),
              ),
              SizedBox(width: 12),
              SizedBox(
                width: 120,
                child: TextField(
                  decoration: InputDecoration(labelText: 'Field B'),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
