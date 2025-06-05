import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

class VulpackInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final TextInputType keyboardType;
  final int? maxLines;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool readOnly;

  const VulpackInputField({
    Key? key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        readOnly: readOnly,
        onChanged: onChanged,
        onTap: onTap,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textTertiary,
            fontSize: AppSizes.textBase,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusLg),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.md,
          ),
        ),
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: AppSizes.textBase,
        ),
      ),
    );
  }
}
