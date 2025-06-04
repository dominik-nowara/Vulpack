import 'package:flutter/material.dart';

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
  final double height;
  final double borderRadius;

  const VulpackButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.buttonStyle = VulpackButtonStyle.filled,
    this.width,
    this.height = 48.0,
    this.borderRadius = 8.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = _getColors();
    final isDisabled = onPressed == null;
    
    return SizedBox(
      width: width,
      height: height,
      child: VulpackButtonStyle == VulpackButtonStyle.filled
          ? _buildFilledButton(colors, isDisabled)
          : _buildOutlinedButton(colors, isDisabled),
    );
  }

  Widget _buildFilledButton(_ButtonColors colors, bool isDisabled) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDisabled ? colors.disabledBackground : colors.background,
        foregroundColor: isDisabled ? colors.disabledText : colors.text,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildOutlinedButton(_ButtonColors colors, bool isDisabled) {
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
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  _ButtonColors _getColors() {
    switch (variant) {
      case ButtonVariant.primary:
        return _ButtonColors(
          background: const Color(0xFFE97A34), // Orange
          text: Colors.white,
          disabledBackground: const Color(0xFFE97A34).withOpacity(0.5),
          disabledText: Colors.white.withOpacity(0.7),
          disabledBorder: const Color(0xFFE97A34).withOpacity(0.3),
        );
      case ButtonVariant.secondary:
        return _ButtonColors(
          background: const Color(0xFF6B7280), // Gray
          text: Colors.white,
          disabledBackground: const Color(0xFF6B7280).withOpacity(0.5),
          disabledText: Colors.white.withOpacity(0.7),
          disabledBorder: const Color(0xFF6B7280).withOpacity(0.3),
        );
      case ButtonVariant.dangerous:
        return _ButtonColors(
          background: const Color(0xFFEF4444), // Red
          text: Colors.white,
          disabledBackground: const Color(0xFFEF4444).withOpacity(0.5),
          disabledText: Colors.white.withOpacity(0.7),
          disabledBorder: const Color(0xFFEF4444).withOpacity(0.3),
        );
      case ButtonVariant.positive:
        return _ButtonColors(
          background: const Color(0xFF10B981), // Green
          text: Colors.white,
          disabledBackground: const Color(0xFF10B981).withOpacity(0.5),
          disabledText: Colors.white.withOpacity(0.7),
          disabledBorder: const Color(0xFF10B981).withOpacity(0.3),
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