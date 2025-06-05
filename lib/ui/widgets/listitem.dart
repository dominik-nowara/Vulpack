import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

class VulpackListItem extends StatelessWidget {
  final Widget? child;
  final List<Widget>? children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final double? spacing;

  const VulpackListItem({
    Key? key,
    this.child,
    this.children,
    this.padding,
    this.margin,
    this.borderRadius,
    this.spacing,
  }) : assert(child != null || children != null),
       assert(child == null || children == null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(AppSizes.md),
      padding: padding ?? EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child ?? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildChildrenWithSpacing(),
      ),
    );
  }

  List<Widget> _buildChildrenWithSpacing() {
    if (children == null || children!.isEmpty) return [];
    
    final effectiveSpacing = spacing ?? AppSizes.sm;
    List<Widget> spacedChildren = [];
    for (int i = 0; i < children!.length; i++) {
      spacedChildren.add(children![i]);
      if (i < children!.length - 1) {
        spacedChildren.add(SizedBox(height: effectiveSpacing));
      }
    }
    return spacedChildren;
  }
}