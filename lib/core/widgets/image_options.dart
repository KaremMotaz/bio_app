import 'package:flutter/material.dart';
import '../../../../core/theming/option_style.dart';

class ImageOptions extends StatelessWidget {
  final List<String> options;
  final int? selectedIndex;
  final bool isEnabled;
  final void Function(int) onSelect;
  final OptionStyle Function(int index) styleBuilder;

  const ImageOptions({
    super.key,
    required this.options,
    required this.selectedIndex,
    required this.isEnabled,
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
            if (isEnabled) {
              onSelect(index);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  backgroundColor: style.circleBackgroundColor,
                  radius: 13,
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: style.borderColor,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: style.shadowColor,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      options[index],
                      height: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
