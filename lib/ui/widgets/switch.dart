import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

class VulpackToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeTrackColor;
  final Color? inactiveTrackColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final double? width;
  final double? height;
  final Duration animationDuration;

  const VulpackToggleSwitch({
    Key? key,
    required this.value,
    this.onChanged,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.width,
    this.height,
    this.animationDuration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<VulpackToggleSwitch> createState() => _VulpackToggleSwitchState();
}

class _VulpackToggleSwitchState extends State<VulpackToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _thumbAnimation;
  late Animation<Color?> _trackColorAnimation;
  late Animation<Color?> _thumbColorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    final width = widget.width ?? AppSizes.switchWidth;
    final height = widget.height ?? AppSizes.switchHeight;

    _thumbAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _trackColorAnimation = ColorTween(
      begin: widget.inactiveTrackColor ?? AppColors.secondaryLight,
      end: widget.activeTrackColor ?? AppColors.primary,
    ).animate(_animationController);

    _thumbColorAnimation = ColorTween(
      begin: widget.inactiveThumbColor ?? AppColors.white,
      end: widget.activeThumbColor ?? AppColors.primaryDark,
    ).animate(_animationController);

    if (widget.value) {
      _animationController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(VulpackToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.onChanged != null) {
      widget.onChanged!(!widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width ?? AppSizes.switchWidth;
    final height = widget.height ?? AppSizes.switchHeight;
    
    // Calculate thumb size and margin
    const double margin = 2.0;
    final double thumbSize = height - (margin * 2);
    
    // Calculate the travel distance for the thumb
    // From left margin to right margin
    final double travelDistance = width - thumbSize - (margin * 2);

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          // Calculate thumb position: starts at margin, ends at margin from right
          final thumbOffset = margin + (_thumbAnimation.value * travelDistance);
          
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height / 2),
              color: _trackColorAnimation.value,
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  left: thumbOffset,
                  top: margin,
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _thumbColorAnimation.value,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}