import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../theme/colors_custom.dart';


class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final bool isLoading;
  final IconData? icon;
  final double? elevation;
  final EdgeInsets? padding;
  final bool isOutlined;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height = 48,
    this.borderRadius,
    this.isLoading = false,
    this.icon,
    this.elevation,
    this.padding,
    this.isOutlined = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width ?? double.infinity, height ?? 48),
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(24),
          ),
          side: BorderSide(
            color: backgroundColor ?? AppColors.primaryPurple,
            width: 2,
          ),
        ),
        child: _buildChild(),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryPurple,
          elevation: elevation ?? 4,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(24),
          ),
          padding: padding,
        ),
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(AppColors.textPrimary),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor ?? AppColors.textPrimary),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.buttonText.copyWith(
              color: textColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      );
    }

    return Text(
      label,
      style: AppTextStyles.buttonText.copyWith(
        color: textColor ?? AppColors.textPrimary,
      ),
    );
  }
}