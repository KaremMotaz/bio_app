import 'package:flutter/material.dart';

import '../theming/option_style.dart';

class TrueFalseOptions extends StatelessWidget {
  final List<String> options;
  final void Function(int index) onSelect;
  final OptionStyle Function(int index) styleBuilder;

  const TrueFalseOptions({
    super.key,
    required this.options,
    required this.onSelect,
    required this.styleBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        final OptionStyle style = styleBuilder(index);

        return GestureDetector(
          onTap: () {
            onSelect(index);
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: style.backgroundColor,
              border: Border.all(color: style.borderColor, width: 2),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: style.shadowColor,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              options[index],
              style: style.textStyle,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }),
    );
  }
}
