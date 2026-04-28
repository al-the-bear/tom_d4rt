// Fa5 reproducer — script-defined InheritedModel<T> subclass + child that
// calls InheritedModel.inheritFrom<MyModel>(context, aspect: ...).
//
// Hypothesis (Fa5 cluster doc): the interpreted subclass collapses to
// `_InterpretedInheritedWidget`, so Flutter's type-keyed lookup misses.
//
// Expected behaviour after Plan E (the static interceptor on
// `InheritedModel.inheritFrom`) landed: the interpreter walks ancestors,
// matches by `_InterpretedInheritedWidget._instance.klass.name`, registers
// the dependency, and returns the InterpretedInstance so script field
// reads dispatch through the InterpretedClass.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

enum CounterAspect { value, label }

class CounterModel extends InheritedModel<CounterAspect> {
  final int value;
  final String label;

  const CounterModel({
    super.key,
    required this.value,
    required this.label,
    required super.child,
  });

  static CounterModel? of(BuildContext context, {CounterAspect? aspect}) {
    return InheritedModel.inheritFrom<CounterModel>(context, aspect: aspect);
  }

  @override
  bool updateShouldNotify(CounterModel oldWidget) =>
      value != oldWidget.value || label != oldWidget.label;

  @override
  bool updateShouldNotifyDependent(
    CounterModel oldWidget,
    Set<CounterAspect> dependencies,
  ) {
    if (dependencies.contains(CounterAspect.value) &&
        value != oldWidget.value) {
      return true;
    }
    if (dependencies.contains(CounterAspect.label) &&
        label != oldWidget.label) {
      return true;
    }
    return false;
  }
}

class _ValueReader extends StatelessWidget {
  const _ValueReader();

  @override
  Widget build(BuildContext context) {
    final model = CounterModel.of(context, aspect: CounterAspect.value);
    print('[fa5-im] value-reader model=${model == null ? 'NULL' : 'ok'}');
    if (model == null) {
      throw StateError(
        'fa5-im: InheritedModel.inheritFrom<CounterModel>(aspect: value) '
        'returned null — interpreted InheritedModel runtimeType collapse',
      );
    }
    if (model.value != 7) {
      throw StateError(
        'fa5-im: value-reader saw wrong value — expected 7, got ${model.value}',
      );
    }
    return Text('value=${model.value}');
  }
}

class _LabelReader extends StatelessWidget {
  const _LabelReader();

  @override
  Widget build(BuildContext context) {
    final model = CounterModel.of(context, aspect: CounterAspect.label);
    print('[fa5-im] label-reader model=${model == null ? 'NULL' : 'ok'}');
    if (model == null) {
      throw StateError(
        'fa5-im: InheritedModel.inheritFrom<CounterModel>(aspect: label) '
        'returned null — interpreted InheritedModel runtimeType collapse',
      );
    }
    if (model.label != 'fa5-im-test') {
      throw StateError(
        'fa5-im: label-reader saw wrong label — expected "fa5-im-test", '
        'got "${model.label}"',
      );
    }
    return Text('label="${model.label}"');
  }
}

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const Scaffold(
      body: CounterModel(
        value: 7,
        label: 'fa5-im-test',
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _ValueReader(),
              _LabelReader(),
            ],
          ),
        ),
      ),
    ),
  );
}
