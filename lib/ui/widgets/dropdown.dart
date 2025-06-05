import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

class VulpackDropdown<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?)? onChanged;
  final String hintText;
  final bool enabled;

  const VulpackDropdown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = 'Select',
    this.enabled = true,
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
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
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
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.textTertiary,
            fontSize: AppSizes.textBase,
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: AppColors.textPrimary,
        ),
        items: items,
        onChanged: enabled ? onChanged : null,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: AppSizes.textBase,
        ),
      ),
    );
  }
}
