import 'package:flutter/material.dart';

import '../../../../core/theming/app_colors.dart';
import '../../../../core/theming/text_styles.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isEnabled;
  final String text;
  final Color? color;
  final Color? shadowColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    this.isEnabled = false,
    this.text = "افحص",
    this.color,
    this.shadowColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (widget.isEnabled) {
      setState(() {
        _isPressed = true;
      });
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.isEnabled) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  void _onTapCancel() {
    if (widget.isEnabled) {
      setState(() {
        _isPressed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isEnabled ? widget.onPressed : null,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 55,
        width: double.infinity,
        transform: _isPressed
            ? Matrix4.translationValues(0, 4, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: widget.isEnabled
              ? widget.color ?? AppColors.mainBlue
              : AppColors.lightGray,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyles.bold17.copyWith(
              color: widget.isEnabled
                  ? AppColors.white
                  : AppColors.gray,
            ),
          ),
        ),
      ),
    );
  }
}
