import 'package:flutter/material.dart';

import 'answer_button.dart';

class AnswerList extends StatelessWidget {
  const AnswerList({
    super.key,
    required this.options,
    required this.enabled,
    required this.stateForIndex,
    required this.onSelected,
  });

  final List<String> options;
  final bool enabled;
  final AnswerState Function(int index) stateForIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < options.length; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          AnswerButton(
            label: options[i],
            state: stateForIndex(i),
            enabled: enabled,
            onPressed: () => onSelected(i),
          ),
        ],
      ],
    );
  }
}
