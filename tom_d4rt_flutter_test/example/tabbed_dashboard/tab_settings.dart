// Settings tab — a `Slider` and a `TextField` for the dashboard
// label.
//
// Uses `AutomaticKeepAliveClientMixin` so values entered here
// survive switching to the Chart/Log tab and back; this is the
// whole point of the keep-alive mixin in this sample.
//
// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab>
    with AutomaticKeepAliveClientMixin {
  double _threshold = 0.5;
  final TextEditingController _label =
      TextEditingController(text: 'Dashboard');

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _label.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text('Threshold'),
          Slider(
            key: const Key('settings-threshold-slider'),
            min: 0.0,
            max: 1.0,
            value: _threshold,
            onChanged: (double v) {
              setState(() {
                _threshold = v;
              });
              print('settings.threshold=${v.toStringAsFixed(2)}');
            },
          ),
          Text(
            'Threshold: ${_threshold.toStringAsFixed(2)}',
            key: const Key('settings-threshold-label'),
          ),
          const SizedBox(height: 16.0),
          const Text('Label'),
          TextField(
            key: const Key('settings-label-field'),
            controller: _label,
            onChanged: (String v) => print('settings.label=$v'),
          ),
        ],
      ),
    );
  }
}
