// Reproduces B.10 — private script class with a parameterized unnamed ctor.
//
// Script-local private classes with an argument-taking unnamed constructor
// raise "does not have an unnamed constructor that accepts arguments" — an
// interpreter constructor-resolution gap for interpreted (not bridged) classes.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class _Stage {
  final String name;
  _Stage(this.name);
}

dynamic build(BuildContext context) {
  final stage = _Stage('alpha');
  return Center(child: Text(stage.name));
}
