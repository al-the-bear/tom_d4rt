// Reproduces B.7 — `_ConstMap` (const {}) missing from Map bridge nativeNames.
//
// A const map literal has runtime type `_ConstMap`, which is not listed in the
// Map BridgedClass `nativeNames`, so member access on it throws.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

const Map<String, int> _scores = {'a': 1, 'b': 2, 'c': 3};

dynamic build(BuildContext context) {
  final keys = _scores.keys.toList();
  return Center(child: Text('${keys.length}'));
}
