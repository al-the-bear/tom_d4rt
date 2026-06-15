// Copy-paste snippet: three button styles, each showing a SnackBar.
import 'package:flutter/material.dart';

Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Buttons')),
    body: Center(
      child: Wrap(
        spacing: 12,
        children: [
          ElevatedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Elevated tapped')),
            ),
            child: const Text('Elevated'),
          ),
          OutlinedButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Outlined tapped')),
            ),
            child: const Text('Outlined'),
          ),
          FilledButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Filled tapped')),
            ),
            child: const Text('Filled'),
          ),
        ],
      ),
    ),
  );
}
