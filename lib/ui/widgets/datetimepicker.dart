import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

class VulpackDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;
  final String? hintText;
  final bool enabled;

  const VulpackDatePicker({
    Key? key,
    required this.selectedDate,
    required this.onDateChanged,
    this.hintText,
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
      child: InkWell(
        onTap: enabled ? () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030),
          );
          if (picked != null && picked != selectedDate) {
            onDateChanged(picked);
          }
        } : null,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.md,
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: AppColors.textPrimary,
                size: AppSizes.iconSm,
              ),
              SizedBox(width: AppSizes.sm),
              Text(
                '${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.year}',
                style: TextStyle(
                  color: enabled ? AppColors.textPrimary : AppColors.textDisabled,
                  fontSize: AppSizes.textBase,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}