import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

class VulpackTabsWidget extends StatefulWidget {
  final List<String> tabs;
  final Function(int)? onTabChanged;
  final Duration animationDuration;

  const VulpackTabsWidget({
    Key? key,
    required this.tabs,
    this.onTabChanged,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : super(key: key);

  @override
  State<VulpackTabsWidget> createState() => _VulpackTabsWidgetState();
}

class _VulpackTabsWidgetState extends State<VulpackTabsWidget> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: widget.tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tabText = entry.value;
          bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onTabChanged?.call(index);
              },
              child: AnimatedContainer(
                duration: widget.animationDuration,
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(
                  vertical: AppSizes.md,
                  horizontal: AppSizes.sm,
                ),
                margin: EdgeInsets.symmetric(horizontal: AppSizes.xs),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.secondary 
                      : AppColors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                  boxShadow: isSelected ? [
                    BoxShadow(
                      color: AppColors.secondary.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ] : null,
                ),
                child: AnimatedDefaultTextStyle(
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    color: isSelected ? AppColors.white : AppColors.textPrimary,
                    fontSize: AppSizes.textBase,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                  child: Text(
                    tabText,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}