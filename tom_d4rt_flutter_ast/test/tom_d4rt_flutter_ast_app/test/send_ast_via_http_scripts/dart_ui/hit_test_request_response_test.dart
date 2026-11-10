// ignore_for_file: avoid_print, unnecessary_type_check
// D4rt test script: HitTestRequest and HitTestResponse (dart:ui, Flutter 3.47).
//
// The engine asks the framework to hit test a view at a position with a
// HitTestRequest and receives a HitTestResponse saying whether a platform
// view was hit. The script builds requests for the current view, and
// responses including the shared `HitTestResponse.empty`.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== HitTestRequest / HitTestResponse ===');
  final view = View.of(context);
  final requests = <ui.HitTestRequest>[
    ui.HitTestRequest(view: view, offset: Offset.zero),
    ui.HitTestRequest(view: view, offset: const Offset(120, 80)),
  ];
  for (final request in requests) {
    print(
      'request at ${request.offset}, same view: '
      '${identical(request.view, view)}',
    );
  }

  const hit = ui.HitTestResponse(hasPlatformView: true);
  const miss = ui.HitTestResponse(hasPlatformView: false);
  final empty = ui.HitTestResponse.empty;
  print('hit hasPlatformView: ${hit.hasPlatformView}');
  print('miss hasPlatformView: ${miss.hasPlatformView}');
  print('empty hasPlatformView: ${empty.hasPlatformView}');
  print('empty is a response: ${empty is ui.HitTestResponse}');

  final responses = <String, ui.HitTestResponse>{
    'platform view': hit,
    'Flutter content': miss,
    'empty': empty,
  };
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (final request in requests)
        ListTile(
          leading: const Icon(Icons.ads_click),
          title: Text('HitTestRequest at ${request.offset}'),
        ),
      for (final entry in responses.entries)
        ListTile(
          leading: Icon(
            entry.value.hasPlatformView ? Icons.check_circle : Icons.cancel,
          ),
          title: Text(entry.key),
          subtitle: Text('hasPlatformView: ${entry.value.hasPlatformView}'),
        ),
    ],
  );
}
