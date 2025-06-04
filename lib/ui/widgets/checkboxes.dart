import 'package:flutter/material.dart';

class VulpackCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;
  final double borderRadius;
  final Color checkedColor;
  final Color uncheckedColor;
  final Color checkColor;

  const VulpackCheckbox({
    Key? key,
    required this.value,
    this.onChanged,
    this.size = 56.0,
    this.borderRadius = 12.0,
    this.checkedColor = const Color(0xFFFF6B35),
    this.uncheckedColor = const Color(0xFFE8E4F3),
    this.checkColor = Colors.white,
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
    return GestureDetector(
      onTap: widget.onChanged != null
          ? () => widget.onChanged!(!widget.value)
          : null,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.value ? widget.checkedColor : widget.uncheckedColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
                color: widget.checkColor,
                size: widget.size * 0.5,
              ),
            );
          },
        ),
      ),
    );
  }
}