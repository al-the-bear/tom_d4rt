import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  const rows = <Map<String, String>>[
    {'label': 'Class', 'value': 'TooltipWindow'},
    {'label': 'Kind', 'value': 'Widget (window-layer tooltip)'},
    {'label': 'Purpose', 'value': 'Models tooltip content in a distinct window layer for clipping and z-order control'},
    {'label': 'Key property', 'value': 'overlayController — manages window-layer overlay lifecycle'},
    {'label': 'Related', 'value': 'Tooltip, OverlayPortal'},
    {'label': 'Use-case', 'value': 'Multi-window or z-order-sensitive tooltip display'},
    {'label': 'Flutter layer', 'value': 'widgets (tooltip)'},
  ];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: const Color(0xFF1A237E),
    ),
    home: Scaffold(
      appBar: AppBar(
        title: const Text('TooltipWindow Summary'),
      ),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context, index) {
          final row = rows[index];
          return ListTile(
            leading: Text(
              '${index + 1}',
              style: const TextStyle(color: Color(0xFF26A69A), fontSize: 16),
            ),
            title: Text(row['label']!,
                style: const TextStyle(
                    color: Color(0xFFFFD27A), fontWeight: FontWeight.w700)),
            subtitle: Text(row['value']!,
                style: const TextStyle(color: Color(0xFFE8EAF6))),
          );
        },
      ),
    ),
  );
}
