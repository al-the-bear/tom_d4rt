// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== RequestFocusAction Deep Demo (Harness-Safe) ===');

  const focusMap = <String>[
    'node ordering',
    'shortcut handoff',
    'fallback target',
    'visual affordance',
    'practical sequence',
  ];

  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('RequestFocusAction')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: focusMap.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                SizedBox(width: 30, child: Text('${index + 1}')),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(focusMap[index]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}
