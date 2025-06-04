// widgets.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vulpack/ui/pages/theme/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? iconColor;
  final double? iconSize;
  final String? tooltip;

  const CustomBackButton({
    Key? key,
    this.onPressed,
    this.iconColor,
    this.iconSize = 24.0,
    this.tooltip = 'back',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: onPressed ?? () => context.pop(),
      color: iconColor,
      iconSize: iconSize,
      tooltip: tooltip,
    );
  }
}

class AddButton extends StatelessWidget {
  final String route;
  final String label;
  final Color backgroundColor;

  const AddButton({
    super.key,
    required this.route,
    this.label = '+ Add',
    this.backgroundColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      onPressed: () {
        context.go(route);
      },
      child: Text(label),
    );
  }
}

class CustomAppBarWithAdd extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String addButtonRoute;
  final String addButtonLabel;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final double elevation;

  const CustomAppBarWithAdd({
    Key? key,
    required this.title,
    required this.addButtonRoute,
    this.addButtonLabel = '+ Add',
    this.onBackPressed,
    this.backgroundColor = Colors.white,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: CustomBackButton(onPressed: onBackPressed),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: AddButton(
            route: addButtonRoute,
            label: addButtonLabel,
          ),
        ),
      ],
      backgroundColor: backgroundColor,
      elevation: elevation,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}