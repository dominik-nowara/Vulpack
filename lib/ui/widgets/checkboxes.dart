import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

class VulpackCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double? size;
  final double? borderRadius;
  final Color? checkedColor;
  final Color? uncheckedColor;
  final Color? checkColor;

  const VulpackCheckbox({
    Key? key,
    required this.value,
    this.onChanged,
    this.size,
    this.borderRadius,
    this.checkedColor,
    this.uncheckedColor,
    this.checkColor,
  }) : super(key: key);

  @override
  State<VulpackCheckbox> createState() => _VulpackCheckboxState();
}

class _VulpackCheckboxState extends State<VulpackCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.value) {
      _animationController.forward();
    }
  }

  @override
  void didUpdateWidget(VulpackCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
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

  @override
  Widget build(BuildContext context) {
    final size = widget.size ?? AppSizes.lg;
    final borderRadius = widget.borderRadius ?? AppSizes.radiusMd;
    final checkedColor = widget.checkedColor ?? AppColors.primary;
    final uncheckedColor = widget.uncheckedColor ?? AppColors.secondaryLight;
    final checkColor = widget.checkColor ?? AppColors.white;

    return GestureDetector(
      onTap: widget.onChanged != null
          ? () => widget.onChanged!(!widget.value)
          : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: widget.value ? checkedColor : uncheckedColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Icon(
                Icons.check,
                color: checkColor,
                size: size * 0.5,
              ),
            );
          },
        ),
      ),
    );
  }
}