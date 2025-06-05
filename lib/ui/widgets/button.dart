import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

enum ButtonVariant {
  primary,
  secondary,
  dangerous,
  positive,
}

enum VulpackButtonStyle {
  filled,
  outlined,
}

class VulpackButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final VulpackButtonStyle buttonStyle;
  final double? width;
  final double? height;
  final double? borderRadius;

  const VulpackButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.buttonStyle = VulpackButtonStyle.filled,
    this.width,
    this.height,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final isDisabled = onPressed == null;
    final effectiveHeight = height ?? AppSizes.buttonHeight;
    final effectiveRadius = borderRadius ?? AppSizes.radiusMd;
    
    return SizedBox(
      width: width,
      height: effectiveHeight,
      child: buttonStyle == VulpackButtonStyle.filled
          ? _buildFilledButton(colors, isDisabled, effectiveRadius)
          : _buildOutlinedButton(colors, isDisabled, effectiveRadius),
    );
  }

  Widget _buildFilledButton(_ButtonColors colors, bool isDisabled, double radius) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? colors.disabledBackground : colors.background,
        foregroundColor: isDisabled ? colors.disabledText : colors.text,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppSizes.textBase,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(_ButtonColors colors, bool isDisabled, double radius) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: isDisabled ? colors.disabledText : colors.background,
        side: BorderSide(
          color: isDisabled ? colors.disabledBorder : colors.background,
          width: 1.5,
        ),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: AppSizes.textBase,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _ButtonColors _getColors() {
    switch (variant) {
      case ButtonVariant.primary:
        return _ButtonColors(
          background: AppColors.primary,
          text: AppColors.white,
          disabledBackground: AppColors.primary.withOpacity(0.5),
          disabledText: AppColors.white.withOpacity(0.7),
          disabledBorder: AppColors.primary.withOpacity(0.3),
        );
      case ButtonVariant.secondary:
        return _ButtonColors(
          background: AppColors.secondary,
          text: AppColors.white,
          disabledBackground: AppColors.secondary.withOpacity(0.5),
          disabledText: AppColors.white.withOpacity(0.7),
          disabledBorder: AppColors.secondary.withOpacity(0.3),
        );
      case ButtonVariant.dangerous:
        return _ButtonColors(
          background: AppColors.error,
          text: AppColors.white,
          disabledBackground: AppColors.error.withOpacity(0.5),
          disabledText: AppColors.white.withOpacity(0.7),
          disabledBorder: AppColors.error.withOpacity(0.3),
        );
      case ButtonVariant.positive:
        return _ButtonColors(
          background: AppColors.success,
          text: AppColors.white,
          disabledBackground: AppColors.success.withOpacity(0.5),
          disabledText: AppColors.white.withOpacity(0.7),
          disabledBorder: AppColors.success.withOpacity(0.3),
        );
    }
  }
}

class _ButtonColors {
  final Color background;
  final Color text;
  final Color disabledBackground;
  final Color disabledText;
  final Color disabledBorder;

  _ButtonColors({
    required this.background,
    required this.text,
    required this.disabledBackground,
    required this.disabledText,
    required this.disabledBorder,
  });
}