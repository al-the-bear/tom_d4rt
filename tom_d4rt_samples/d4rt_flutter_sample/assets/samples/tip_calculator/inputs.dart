// Bill / tip / party inputs panel for the tip_calculator sample.
//
// Three controls owned by the parent state:
//   * Bill `TextField`            - key `bill-field`, paired with an
//                                   explicit `FocusNode` so the
//                                   focus-traversal test can reason
//                                   about which field is active.
//   * Tip percent `Slider` (0-30) - key `tip-slider`. Live label
//                                   shows the integer percent.
//   * Party stepper               - two `IconButton`s with keys
//                                   `party-minus` / `party-plus`,
//                                   plus a `Key('party-count')` text
//                                   showing the current size.
//
// All callbacks are owned by the parent. This widget is stateful only
// to host its `FocusNode`s (it does NOT own the controller — the
// parent does that so the controller survives currency changes).
import 'package:flutter/material.dart';

class TipInputs extends StatefulWidget {
  final TextEditingController billController;
  final double tipPct;
  final int party;
  final ValueChanged<double> onTipChanged;
  final ValueChanged<int> onPartyChanged;
  final VoidCallback onBillSubmitted;

  const TipInputs({
    super.key,
    required this.billController,
    required this.tipPct,
    required this.party,
    required this.onTipChanged,
    required this.onPartyChanged,
    required this.onBillSubmitted,
  });

  @override
  State<TipInputs> createState() => _TipInputsState();
}

class _TipInputsState extends State<TipInputs> {
  late FocusNode _billFocus;
  late FocusNode _minusFocus;
  late FocusNode _plusFocus;

  @override
  void initState() {
    super.initState();
    _billFocus = FocusNode(debugLabel: 'tip.bill');
    _minusFocus = FocusNode(debugLabel: 'tip.party.minus');
    _plusFocus = FocusNode(debugLabel: 'tip.party.plus');
  }

  @override
  void dispose() {
    _billFocus.dispose();
    _minusFocus.dispose();
    _plusFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            key: const Key('bill-field'),
            controller: widget.billController,
            focusNode: _billFocus,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              labelText: 'Bill',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (_) => widget.onBillSubmitted(),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: <Widget>[
              SizedBox(
                width: 96.0,
                child: Text(
                  'Tip ${widget.tipPct.round()}%',
                  key: const Key('tip-label'),
                ),
              ),
              Expanded(
                child: Slider(
                  key: const Key('tip-slider'),
                  min: 0.0,
                  max: 30.0,
                  divisions: 30,
                  value: widget.tipPct.clamp(0.0, 30.0),
                  onChanged: widget.onTipChanged,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: <Widget>[
              const SizedBox(width: 8.0),
              const Text('Party:'),
              const SizedBox(width: 12.0),
              IconButton(
                key: const Key('party-minus'),
                focusNode: _minusFocus,
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: widget.party > 1
                    ? () => widget.onPartyChanged(widget.party - 1)
                    : null,
                tooltip: 'Smaller party',
              ),
              SizedBox(
                width: 40.0,
                child: Center(
                  child: Text(
                    '${widget.party}',
                    key: const Key('party-count'),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              IconButton(
                key: const Key('party-plus'),
                focusNode: _plusFocus,
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () => widget.onPartyChanged(widget.party + 1),
                tooltip: 'Larger party',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
