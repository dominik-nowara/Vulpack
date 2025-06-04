import 'package:flutter/material.dart';

class VulpackToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color activeThumbColor;
  final Color inactiveThumbColor;
  final double width;
  final double height;
  final Duration animationDuration;

  const VulpackToggleSwitch({
    Key? key,
    required this.value,
    this.onChanged,
    this.activeTrackColor = const Color(0xFFFF6B35),
    this.inactiveTrackColor = const Color(0xFFE0E0E8),
    this.activeThumbColor = const Color(0xFFD54A1F),
    this.inactiveThumbColor = const Color(0xFF9E9EAB),
    this.width = 60.0,
    this.height = 32.0,
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

    _thumbAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _trackColorAnimation = ColorTween(
      begin: widget.inactiveTrackColor,
      end: widget.activeTrackColor,
    ).animate(_animationController);

    _thumbColorAnimation = ColorTween(
      begin: widget.inactiveThumbColor,
      end: widget.activeThumbColor,
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
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          final thumbOffset = _thumbAnimation.value * (widget.width - widget.height);
          
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.height / 2),
              color: _trackColorAnimation.value,
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  left: thumbOffset,
                  top: 2,
                  child: Container(
                    width: widget.height - 4,
                    height: widget.height - 4,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _thumbColorAnimation.value,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
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