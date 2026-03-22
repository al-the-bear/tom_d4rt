// D4rt test script: Deep demo for OverScrollHeaderStretchConfiguration
// OverScrollHeaderStretchConfiguration - configuration for overscroll stretch effects in sliver headers
//
// OverScrollHeaderStretchConfiguration controls how SliverPersistentHeader widgets
// respond to overscrolling by stretching beyond their natural bounds. This creates
// the elastic stretch effect commonly seen when pulling down on a scrollable list
// that already shows the top content.
//
// Key properties:
//   - stretchTriggerOffset: Distance to stretch before trigger fires (default 100.0)
//   - onStretchTrigger: Optional callback when stretch threshold is reached
//
// ════════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ════════════════════════════════════════════════════════════════════════════
// SECTION 1: Basic Configuration
// ════════════════════════════════════════════════════════════════════════════
//
// OverScrollHeaderStretchConfiguration is created with minimal required parameters.
// The constructor accepts an optional stretchTriggerOffset and onStretchTrigger.
//
// Example instantiation:
//   OverScrollHeaderStretchConfiguration(
//     stretchTriggerOffset: 100.0,
//     onStretchTrigger: () async { print('Stretched!'); },
//   )
//
// When used with SliverAppBar, set stretch: true to enable the behavior.
//
// ════════════════════════════════════════════════════════════════════════════

class BasicConfigurationWidget extends StatefulWidget {
  BasicConfigurationWidget({Key? key}) : super(key: key);

  @override
  State<BasicConfigurationWidget> createState() => _BasicConfigurationWidgetState();
}

class _BasicConfigurationWidgetState extends State<BasicConfigurationWidget> {
  String _statusMessage = 'Ready to demonstrate configuration';
  int _configCount = 0;
  bool _hasCallback = false;
  double _triggerOffset = 100.0;

  void _createDefaultConfiguration() {
    _configCount++;
    _hasCallback = false;
    _triggerOffset = 100.0;
    setState(() {
      _statusMessage = 'Created default config #$_configCount (offset: 100.0, no callback)';
    });
  }

  void _createWithCallback() {
    _configCount++;
    _hasCallback = true;
    _triggerOffset = 100.0;
    setState(() {
      _statusMessage = 'Created config #$_configCount with onStretchTrigger callback';
    });
  }

  void _createCustomOffset() {
    _configCount++;
    _hasCallback = false;
    _triggerOffset = 150.0;
    setState(() {
      _statusMessage = 'Created config #$_configCount with custom offset: 150.0';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF81C784)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.settings, color: Color(0xFF388E3C), size: 24),
              SizedBox(width: 8),
              Text(
                'Basic Configuration',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'OverScrollHeaderStretchConfiguration(\n'
              '  stretchTriggerOffset: double = 100.0,\n'
              '  onStretchTrigger: Future<void> Function()?,\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFA5D6A7),
              ),
            ),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                onPressed: _createDefaultConfiguration,
                icon: Icon(Icons.play_circle_outline),
                label: Text('Default'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _createWithCallback,
                icon: Icon(Icons.notifications_active),
                label: Text('With Callback'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF66BB6A),
                  foregroundColor: Colors.white,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _createCustomOffset,
                icon: Icon(Icons.straighten),
                label: Text('Custom Offset'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF81C784),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF388E3C), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _statusMessage,
                    style: TextStyle(fontSize: 13, color: Color(0xFF1B5E20)),
                  ),
                ),
              ],
            ),
          ),
          if (_configCount > 0)
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Config Details:\n'
                  '  stretchTriggerOffset: $_triggerOffset\n'
                  '  hasCallback: $_hasCallback',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Color(0xFFA5D6A7),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 2: stretchTriggerOffset Variations
// ════════════════════════════════════════════════════════════════════════════
//
// The stretchTriggerOffset determines how far the user must pull beyond the
// scroll boundary before the onStretchTrigger callback fires.
//
// Common values:
//   - 50.0: Very sensitive, triggers quickly
//   - 100.0: Default, balanced feel
//   - 150.0: Requires more deliberate pull
//   - 200.0: Significant stretch needed
//
// Lower values make the stretch trigger more responsive but may fire
// accidentally. Higher values require more intentional user action.
//
// ════════════════════════════════════════════════════════════════════════════

class OffsetPreset {
  String label;
  double value;
  String description;
  Color color;

  OffsetPreset({
    required this.label,
    required this.value,
    required this.description,
    required this.color,
  });
}

class StretchTriggerOffsetWidget extends StatefulWidget {
  StretchTriggerOffsetWidget({Key? key}) : super(key: key);

  @override
  State<StretchTriggerOffsetWidget> createState() => _StretchTriggerOffsetWidgetState();
}

class _StretchTriggerOffsetWidgetState extends State<StretchTriggerOffsetWidget> {
  double _currentOffset = 100.0;
  int _selectedPresetIndex = 1;
  List<OffsetPreset> _presets = [];

  @override
  void initState() {
    super.initState();
    _initPresets();
  }

  void _initPresets() {
    _presets = [
      OffsetPreset(
        label: 'Quick',
        value: 50.0,
        description: 'Very sensitive trigger',
        color: Color(0xFFF44336),
      ),
      OffsetPreset(
        label: 'Default',
        value: 100.0,
        description: 'Balanced, standard feel',
        color: Color(0xFF4CAF50),
      ),
      OffsetPreset(
        label: 'Moderate',
        value: 150.0,
        description: 'Deliberate pull required',
        color: Color(0xFF2196F3),
      ),
      OffsetPreset(
        label: 'Extended',
        value: 200.0,
        description: 'Significant stretch needed',
        color: Color(0xFF9C27B0),
      ),
      OffsetPreset(
        label: 'Maximum',
        value: 300.0,
        description: 'Very long stretch distance',
        color: Color(0xFFFF9800),
      ),
    ];
  }

  void _selectPreset(int index) {
    setState(() {
      _selectedPresetIndex = index;
      _currentOffset = _presets[index].value;
    });
  }

  void _adjustOffset(double delta) {
    setState(() {
      _currentOffset = (_currentOffset + delta).clamp(10.0, 500.0);
      _selectedPresetIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF90CAF9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.straighten, color: Color(0xFF1976D2), size: 24),
              SizedBox(width: 8),
              Text(
                'stretchTriggerOffset Variations',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The stretchTriggerOffset controls how far the header must stretch '
            'before the onStretchTrigger callback fires.',
            style: TextStyle(fontSize: 13, color: Color(0xFF1565C0)),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFBBDEFB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  '${_currentOffset.toStringAsFixed(1)} px',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1976D2),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _adjustOffset(-10),
                      icon: Icon(Icons.remove_circle),
                      color: Color(0xFF1976D2),
                    ),
                    Expanded(
                      child: Slider(
                        value: _currentOffset,
                        min: 10.0,
                        max: 500.0,
                        divisions: 49,
                        activeColor: Color(0xFF1976D2),
                        inactiveColor: Color(0xFF90CAF9),
                        onChanged: (value) {
                          setState(() {
                            _currentOffset = value;
                            _selectedPresetIndex = -1;
                          });
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () => _adjustOffset(10),
                      icon: Icon(Icons.add_circle),
                      color: Color(0xFF1976D2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Presets:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D47A1),
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_presets.length, (index) {
              var preset = _presets[index];
              var isSelected = index == _selectedPresetIndex;
              return GestureDetector(
                onTap: () => _selectPreset(index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? preset.color : preset.color.withAlpha(50),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: preset.color,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    '${preset.label}: ${preset.value.toInt()}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : preset.color,
                    ),
                  ),
                ),
              );
            }),
          ),
          if (_selectedPresetIndex >= 0 && _selectedPresetIndex < _presets.length)
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xFF263238),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'OverScrollHeaderStretchConfiguration(\n'
                  '  stretchTriggerOffset: ${_presets[_selectedPresetIndex].value},\n'
                  '  // ${_presets[_selectedPresetIndex].description}\n'
                  ')',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11,
                    color: Color(0xFFBBDEFB),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 3: onStretchTrigger Callback
// ════════════════════════════════════════════════════════════════════════════
//
// The onStretchTrigger callback is an async function that fires when the
// stretch exceeds stretchTriggerOffset. This enables pull-to-refresh patterns
// and similar user interactions.
//
// Callback signature: Future<void> Function()?
//
// Common use cases:
//   - Refresh data from server
//   - Show loading indicator
//   - Trigger haptic feedback
//   - Navigate to a page
//
// The callback is optional - if null, stretch visual still works.
//
// ════════════════════════════════════════════════════════════════════════════

class OnStretchTriggerWidget extends StatefulWidget {
  OnStretchTriggerWidget({Key? key}) : super(key: key);

  @override
  State<OnStretchTriggerWidget> createState() => _OnStretchTriggerWidgetState();
}

class _OnStretchTriggerWidgetState extends State<OnStretchTriggerWidget> {
  List<String> _triggerLog = [];
  int _triggerCount = 0;
  bool _isTriggering = false;
  String _selectedAction = 'Log Message';

  void _simulateTrigger() {
    if (_isTriggering) return;
    setState(() {
      _isTriggering = true;
    });
    _triggerCount++;
    var timestamp = DateTime.now().toString().substring(11, 19);
    var logEntry = '[$timestamp] Trigger #$_triggerCount: $_selectedAction';
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _triggerLog.insert(0, logEntry);
        if (_triggerLog.length > 5) {
          _triggerLog.removeLast();
        }
        _isTriggering = false;
      });
    });
  }

  void _clearLog() {
    setState(() {
      _triggerLog.clear();
      _triggerCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFF48FB1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.notifications_active, color: Color(0xFFC2185B), size: 24),
              SizedBox(width: 8),
              Text(
                'onStretchTrigger Callback',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF880E4F),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'The onStretchTrigger callback fires when the user stretches '
            'beyond the configured offset. It returns Future<void> to '
            'support async operations.',
            style: TextStyle(fontSize: 13, color: Color(0xFFAD1457)),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'onStretchTrigger: () async {\n'
              '  await refreshData();\n'
              '  showSnackbar("Refreshed!");\n'
              '}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Color(0xFFF8BBD0),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Action Type:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF880E4F),
            ),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildActionChip('Log Message', Icons.message),
              _buildActionChip('Refresh Data', Icons.refresh),
              _buildActionChip('Haptic Feedback', Icons.vibration),
              _buildActionChip('Show Snackbar', Icons.info),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isTriggering ? null : _simulateTrigger,
                  icon: _isTriggering
                      ? SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(Icons.flash_on),
                  label: Text(_isTriggering ? 'Triggering...' : 'Simulate Trigger'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE91E63),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 8),
              IconButton(
                onPressed: _clearLog,
                icon: Icon(Icons.delete_outline),
                color: Color(0xFFC2185B),
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _triggerLog.isEmpty
                ? Center(
                    child: Text(
                      'No triggers yet',
                      style: TextStyle(
                        color: Color(0xFF78909C),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: _triggerLog.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          _triggerLog[index],
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: Color(0xFFF8BBD0),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip(String label, IconData icon) {
    var isSelected = _selectedAction == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAction = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFE91E63) : Color(0xFFF8BBD0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Color(0xFFE91E63),
            ),
            SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white : Color(0xFF880E4F),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 4: Stretch Effect Visualization on SliverAppBar
// ════════════════════════════════════════════════════════════════════════════
//
// The stretch effect is most commonly used with SliverAppBar by setting:
//   - stretch: true (enables the stretching behavior)
//   - stretchTriggerOffset: custom value
//   - onStretchTrigger: callback function
//
// As the user overscrolls, the app bar stretches vertically. When the stretch
// exceeds stretchTriggerOffset, onStretchTrigger fires (if provided).
//
// The visual stretching creates a natural, elastic feel that's common in
// modern mobile applications.
//
// ════════════════════════════════════════════════════════════════════════════

class StretchVisualizationWidget extends StatefulWidget {
  StretchVisualizationWidget({Key? key}) : super(key: key);

  @override
  State<StretchVisualizationWidget> createState() => _StretchVisualizationWidgetState();
}

class _StretchVisualizationWidgetState extends State<StretchVisualizationWidget> {
  double _stretchAmount = 0.0;
  double _triggerOffset = 100.0;
  bool _triggered = false;
  int _triggerFlashCount = 0;

  void _updateStretch(double value) {
    setState(() {
      _stretchAmount = value;
      if (_stretchAmount >= _triggerOffset && !_triggered) {
        _triggered = true;
        _triggerFlashCount++;
      } else if (_stretchAmount < _triggerOffset) {
        _triggered = false;
      }
    });
  }

  void _resetStretch() {
    setState(() {
      _stretchAmount = 0.0;
      _triggered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var triggerProgress = (_stretchAmount / _triggerOffset).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFCE93D8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.phone_android, color: Color(0xFF7B1FA2), size: 24),
              SizedBox(width: 8),
              Text(
                'Stretch Effect Visualization',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Drag the slider to simulate overscroll stretch. The header expands '
            'as you stretch, and triggers when the threshold is reached.',
            style: TextStyle(fontSize: 13, color: Color(0xFF6A1B9A)),
          ),
          SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF455A64)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 80 + (_stretchAmount * 0.5),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            _triggered ? Color(0xFFE91E63) : Color(0xFF7B1FA2),
                            _triggered ? Color(0xFFF48FB1) : Color(0xFFAB47BC),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'SliverAppBar',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          if (_stretchAmount > 0)
                            Text(
                              'Stretch: ${_stretchAmount.toStringAsFixed(0)}px',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          if (_triggered)
                            Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.check_circle, color: Colors.white, size: 14),
                                  SizedBox(width: 4),
                                  Text(
                                    'TRIGGERED!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 85 + (_stretchAmount * 0.5),
                    left: 8,
                    right: 8,
                    bottom: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF37474F),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Scroll Content',
                          style: TextStyle(color: Color(0xFF90A4AE)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Stretch:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Slider(
                  value: _stretchAmount,
                  min: 0.0,
                  max: 200.0,
                  activeColor: _triggered ? Color(0xFFE91E63) : Color(0xFF7B1FA2),
                  inactiveColor: Color(0xFFCE93D8),
                  onChanged: _updateStretch,
                ),
              ),
              Text(
                '${_stretchAmount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1FA2),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trigger Progress: ${(triggerProgress * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 12, color: Color(0xFF6A1B9A)),
              ),
              TextButton.icon(
                onPressed: _resetStretch,
                icon: Icon(Icons.refresh, size: 16),
                label: Text('Reset'),
                style: TextButton.styleFrom(foregroundColor: Color(0xFF7B1FA2)),
              ),
            ],
          ),
          SizedBox(height: 8),
          LinearProgressIndicator(
            value: triggerProgress,
            backgroundColor: Color(0xFFE1BEE7),
            valueColor: AlwaysStoppedAnimation<Color>(
              _triggered ? Color(0xFFE91E63) : Color(0xFF7B1FA2),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Trigger flash count: $_triggerFlashCount',
            style: TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
              color: Color(0xFF6A1B9A),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 5: Stretch Modes Comparison
// ════════════════════════════════════════════════════════════════════════════
//
// OverScrollHeaderStretchConfiguration works alongside StretchMode for
// SliverAppBar's flexibleSpace. Available stretch modes:
//
//   - StretchMode.zoomBackground: Background image zooms on stretch
//   - StretchMode.blurBackground: Background blurs on stretch
//   - StretchMode.fadeTitle: Title fades on stretch
//
// Multiple modes can be combined for complex effects. The configuration
// controls the trigger behavior while StretchMode controls visuals.
//
// ════════════════════════════════════════════════════════════════════════════

class StretchModeInfo {
  String name;
  String description;
  IconData icon;
  Color color;
  bool enabled;

  StretchModeInfo({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    this.enabled = false,
  });
}

class StretchModesComparisonWidget extends StatefulWidget {
  StretchModesComparisonWidget({Key? key}) : super(key: key);

  @override
  State<StretchModesComparisonWidget> createState() => _StretchModesComparisonWidgetState();
}

class _StretchModesComparisonWidgetState extends State<StretchModesComparisonWidget> {
  List<StretchModeInfo> _modes = [];
  double _stretchAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _initModes();
  }

  void _initModes() {
    _modes = [
      StretchModeInfo(
        name: 'zoomBackground',
        description: 'Background image scales up as header stretches',
        icon: Icons.zoom_in,
        color: Color(0xFF4CAF50),
        enabled: true,
      ),
      StretchModeInfo(
        name: 'blurBackground',
        description: 'Background blurs progressively on stretch',
        icon: Icons.blur_on,
        color: Color(0xFF2196F3),
      ),
      StretchModeInfo(
        name: 'fadeTitle',
        description: 'Title text fades out during stretch',
        icon: Icons.format_color_text,
        color: Color(0xFFFF9800),
      ),
    ];
  }

  void _toggleMode(int index) {
    setState(() {
      _modes[index].enabled = !_modes[index].enabled;
    });
  }

  String _getActiveModesString() {
    var active = _modes.where((m) => m.enabled).map((m) => 'StretchMode.${m.name}');
    if (active.isEmpty) return '[]';
    return '[\n    ${active.join(',\n    ')},\n  ]';
  }

  @override
  Widget build(BuildContext context) {
    var zoomScale = 1.0 + (_stretchAmount * 0.002);
    var blurAmount = _stretchAmount * 0.1;
    var fadeOpacity = 1.0 - (_stretchAmount * 0.01).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFE082)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.compare, color: Color(0xFFFF6F00), size: 24),
              SizedBox(width: 8),
              Text(
                'Stretch Modes Comparison',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'StretchMode controls visual effects while OverScrollHeaderStretchConfiguration '
            'controls trigger behavior. Modes can be combined.',
            style: TextStyle(fontSize: 13, color: Color(0xFFF57C00)),
          ),
          SizedBox(height: 16),
          ...List.generate(_modes.length, (index) {
            var mode = _modes[index];
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => _toggleMode(index),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: mode.enabled ? mode.color.withAlpha(40) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: mode.enabled ? mode.color : Color(0xFFBDBDBD),
                      width: mode.enabled ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: mode.enabled ? mode.color : Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          mode.icon,
                          color: mode.enabled ? Colors.white : Color(0xFF757575),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'StretchMode.${mode.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: mode.enabled ? mode.color : Color(0xFF616161),
                              ),
                            ),
                            Text(
                              mode.description,
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: mode.enabled,
                        activeColor: mode.color,
                        onChanged: (_) => _toggleMode(index),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          SizedBox(height: 12),
          Text(
            'Effect Preview (stretch: ${_stretchAmount.toStringAsFixed(0)}):',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFE65100),
            ),
          ),
          SizedBox(height: 8),
          Slider(
            value: _stretchAmount,
            min: 0.0,
            max: 100.0,
            activeColor: Color(0xFFFF9800),
            inactiveColor: Color(0xFFFFE082),
            onChanged: (value) {
              setState(() {
                _stretchAmount = value;
              });
            },
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF37474F),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildEffectIndicator(
                  'Zoom',
                  '${zoomScale.toStringAsFixed(2)}x',
                  _modes[0].enabled,
                  Color(0xFF4CAF50),
                ),
                _buildEffectIndicator(
                  'Blur',
                  '${blurAmount.toStringAsFixed(1)}σ',
                  _modes[1].enabled,
                  Color(0xFF2196F3),
                ),
                _buildEffectIndicator(
                  'Fade',
                  '${(fadeOpacity * 100).toStringAsFixed(0)}%',
                  _modes[2].enabled,
                  Color(0xFFFF9800),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'SliverAppBar(\n'
              '  stretch: true,\n'
              '  stretchTriggerOffset: 100.0,\n'
              '  stretchModes: ${_getActiveModesString()},\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFFFFE0B2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEffectIndicator(String label, String value, bool active, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: active ? color : Color(0xFF78909C),
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: active ? color : Color(0xFF546E7A),
          ),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SECTION 6: Custom Stretch Trigger Offsets
// ════════════════════════════════════════════════════════════════════════════
//
// Custom offset values can optimize user experience for different contexts:
//
// Use Case Examples:
//   - Pull-to-Refresh: 60-80px (responsive feel)
//   - Load More Content: 100-120px (standard)
//   - Reveal Hidden Feature: 150-200px (intentional action)
//   - Easter Egg/Secret: 250-400px (discovery moment)
//
// Consider device characteristics:
//   - Smaller screens may need lower offsets
//   - Tablets can handle larger offsets
//   - Platform conventions differ (iOS vs Android)
//
// ════════════════════════════════════════════════════════════════════════════

class UseCaseConfig {
  String name;
  String description;
  double offset;
  IconData icon;
  Color color;

  UseCaseConfig({
    required this.name,
    required this.description,
    required this.offset,
    required this.icon,
    required this.color,
  });
}

class CustomTriggerOffsetsWidget extends StatefulWidget {
  CustomTriggerOffsetsWidget({Key? key}) : super(key: key);

  @override
  State<CustomTriggerOffsetsWidget> createState() => _CustomTriggerOffsetsWidgetState();
}

class _CustomTriggerOffsetsWidgetState extends State<CustomTriggerOffsetsWidget> {
  List<UseCaseConfig> _useCases = [];
  int _selectedIndex = 0;
  double _simulatedStretch = 0.0;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _initUseCases();
  }

  void _initUseCases() {
    _useCases = [
      UseCaseConfig(
        name: 'Pull-to-Refresh',
        description: 'Quick, responsive refresh action',
        offset: 70.0,
        icon: Icons.refresh,
        color: Color(0xFF4CAF50),
      ),
      UseCaseConfig(
        name: 'Load More',
        description: 'Standard content loading trigger',
        offset: 100.0,
        icon: Icons.downloading,
        color: Color(0xFF2196F3),
      ),
      UseCaseConfig(
        name: 'Reveal Feature',
        description: 'Show hidden functionality',
        offset: 180.0,
        icon: Icons.visibility,
        color: Color(0xFF9C27B0),
      ),
      UseCaseConfig(
        name: 'Easter Egg',
        description: 'Secret action for curious users',
        offset: 350.0,
        icon: Icons.auto_awesome,
        color: Color(0xFFFF9800),
      ),
    ];
  }

  void _selectUseCase(int index) {
    setState(() {
      _selectedIndex = index;
      _simulatedStretch = 0.0;
      _triggered = false;
    });
  }

  void _updateStretch(double value) {
    var currentOffset = _useCases[_selectedIndex].offset;
    setState(() {
      _simulatedStretch = value;
      _triggered = value >= currentOffset;
    });
  }

  @override
  Widget build(BuildContext context) {
    var selectedCase = _useCases[_selectedIndex];
    var maxStretch = selectedCase.offset * 1.5;
    var progress = (_simulatedStretch / selectedCase.offset).clamp(0.0, 1.0);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFF80DEEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune, color: Color(0xFF00838F), size: 24),
              SizedBox(width: 8),
              Text(
                'Custom Stretch Trigger Offsets',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006064),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'Different use cases require different trigger offsets. Select a '
            'scenario to see the recommended configuration.',
            style: TextStyle(fontSize: 13, color: Color(0xFF00838F)),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(_useCases.length, (index) {
                var useCase = _useCases[index];
                var isSelected = index == _selectedIndex;
                return Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => _selectUseCase(index),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? useCase.color : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: useCase.color, width: 2),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: useCase.color.withAlpha(80),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Column(
                        children: [
                          Icon(
                            useCase.icon,
                            color: isSelected ? Colors.white : useCase.color,
                            size: 24,
                          ),
                          SizedBox(height: 4),
                          Text(
                            useCase.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : useCase.color,
                            ),
                          ),
                          Text(
                            '${useCase.offset.toInt()}px',
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected ? Colors.white70 : Color(0xFF757575),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: selectedCase.color.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: selectedCase.color.withAlpha(100)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(selectedCase.icon, color: selectedCase.color),
                    SizedBox(width: 8),
                    Text(
                      selectedCase.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: selectedCase.color,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  selectedCase.description,
                  style: TextStyle(fontSize: 13, color: Color(0xFF37474F)),
                ),
                SizedBox(height: 12),
                Text(
                  'Recommended offset: ${selectedCase.offset.toInt()}px',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF37474F),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Simulate Stretch:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF006064)),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Slider(
                  value: _simulatedStretch.clamp(0.0, maxStretch),
                  min: 0.0,
                  max: maxStretch,
                  activeColor: _triggered ? Color(0xFFE91E63) : selectedCase.color,
                  inactiveColor: Color(0xFFB2EBF2),
                  onChanged: _updateStretch,
                ),
              ),
              Container(
                width: 60,
                child: Text(
                  '${_simulatedStretch.toStringAsFixed(0)}px',
                  style: TextStyle(fontWeight: FontWeight.bold, color: selectedCase.color),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progress: ${(progress * 100).toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 12, color: Color(0xFF00838F)),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: _triggered ? Color(0xFFE91E63) : Color(0xFFB0BEC5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _triggered ? 'TRIGGERED' : 'NOT TRIGGERED',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'OverScrollHeaderStretchConfiguration(\n'
              '  stretchTriggerOffset: ${selectedCase.offset},\n'
              '  onStretchTrigger: () async {\n'
              '    // ${selectedCase.description}\n'
              '  },\n'
              ')',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Color(0xFF80DEEA),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// SUMMARY WIDGET
// ════════════════════════════════════════════════════════════════════════════

class SummaryWidget extends StatelessWidget {
  SummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFFCC80)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.summarize, color: Color(0xFFE65100), size: 24),
              SizedBox(width: 8),
              Text(
                'Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _buildSummaryItem(
            'OverScrollHeaderStretchConfiguration controls stretch behavior '
            'for SliverPersistentHeader widgets during overscroll.',
          ),
          _buildSummaryItem(
            'stretchTriggerOffset (default 100.0) determines how far the user '
            'must stretch before onStretchTrigger fires.',
          ),
          _buildSummaryItem(
            'onStretchTrigger is an optional async callback for actions like '
            'pull-to-refresh, loading content, or haptic feedback.',
          ),
          _buildSummaryItem(
            'Used with SliverAppBar by setting stretch: true along with '
            'stretchTriggerOffset and onStretchTrigger.',
          ),
          _buildSummaryItem(
            'Works in combination with StretchMode (zoomBackground, '
            'blurBackground, fadeTitle) for visual effects.',
          ),
          _buildSummaryItem(
            'Custom offset values should match use case: 60-80px for refresh, '
            '100-120px for loading, 150-200px for reveals.',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: Color(0xFFFFB300),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFE65100),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// MAIN DEMO SCAFFOLD
// ════════════════════════════════════════════════════════════════════════════

class OverScrollHeaderStretchConfigurationDemo extends StatelessWidget {
  OverScrollHeaderStretchConfigurationDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            pinned: true,
            stretch: true,
            backgroundColor: Color(0xFF455A64),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'OverScrollHeaderStretchConfiguration',
                style: TextStyle(fontSize: 14),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF607D8B),
                      Color(0xFF455A64),
                      Color(0xFF37474F),
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.expand,
                    size: 64,
                    color: Colors.white24,
                  ),
                ),
              ),
              stretchModes: [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                BasicConfigurationWidget(),
                SizedBox(height: 16),
                StretchTriggerOffsetWidget(),
                SizedBox(height: 16),
                OnStretchTriggerWidget(),
                SizedBox(height: 16),
                StretchVisualizationWidget(),
                SizedBox(height: 16),
                StretchModesComparisonWidget(),
                SizedBox(height: 16),
                CustomTriggerOffsetsWidget(),
                SizedBox(height: 16),
                SummaryWidget(),
                SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════════════════
// MAIN FUNCTION
// ════════════════════════════════════════════════════════════════════════════

void main() {
  runApp(MaterialApp(
    title: 'OverScrollHeaderStretchConfiguration Demo',
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
      useMaterial3: true,
    ),
    home: OverScrollHeaderStretchConfigurationDemo(),
    debugShowCheckedModeBanner: false,
  ));

  print('');
  print('╔═══════════════════════════════════════════════════════════════════╗');
  print('║     OverScrollHeaderStretchConfiguration Deep Demo                ║');
  print('╚═══════════════════════════════════════════════════════════════════╝');
  print('');
  print('OverScrollHeaderStretchConfiguration controls how SliverPersistentHeader');
  print('widgets respond to overscrolling with stretch behavior.');
  print('');
  print('Key Parameters:');
  print('  • stretchTriggerOffset: Distance before trigger (default: 100.0)');
  print('  • onStretchTrigger: Async callback when threshold reached');
  print('');
  print('Usage Context:');
  print('  - Used with SliverAppBar when stretch: true is set');
  print('  - Enables pull-to-refresh and similar overscroll interactions');
  print('  - Works alongside StretchMode for visual stretch effects');
  print('');
  print('stretchTriggerOffset Recommendations:');
  print('  • 60-80px:   Pull-to-refresh (responsive)');
  print('  • 100-120px: Load more content (standard)');
  print('  • 150-200px: Reveal hidden features (intentional)');
  print('  • 250-400px: Easter eggs (discovery)');
  print('');
  print('StretchMode Options:');
  print('  • zoomBackground: Background scales on stretch');
  print('  • blurBackground: Background blurs on stretch');
  print('  • fadeTitle:      Title fades on stretch');
  print('');
  print('OverScrollHeaderStretchConfiguration demo completed.');
}
