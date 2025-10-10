import 'package:flutter/material.dart';
import 'package:my_abans/utils/custom_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isOutlinedButton;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.text,
    this.isOutlinedButton = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isOutlinedButton
              ? Colors.transparent
              : CustomColors.primaryColor,
          border: Border.all(
            color: CustomColors.primaryColor,
            width: isOutlinedButton ? 1 : 0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isOutlinedButton
                  ? CustomColors.primaryColor
                  : Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
