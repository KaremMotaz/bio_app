import '../theming/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theming/option_style.dart';

class ImageOptions extends StatelessWidget {
  final List<String> options;
  final void Function(int) onSelect;
  final OptionStyle Function(int index) styleBuilder;

  const ImageOptions({
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
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                    child: CachedNetworkImage(
                      imageUrl: options[index],
                      height: 150,
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
