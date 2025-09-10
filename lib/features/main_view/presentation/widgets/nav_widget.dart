import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavWidget extends StatelessWidget {
  const NavWidget({
    super.key,
    required this.selectedIndex,
    required this.icons,
    required this.labels,
    required this.index,
  });

  final int selectedIndex;
  final int index;
  final List<String> icons;
  final List<String> labels;
  @override
  Widget build(BuildContext context) {
    final isSelected = selectedIndex == index;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xff0096C7)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icons[index],
            width: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.white : Colors.black,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 8),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isSelected
                ? Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
