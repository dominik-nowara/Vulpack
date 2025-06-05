import 'package:flutter/material.dart';
import 'package:vulpack/theme/app_colors.dart';
import 'package:vulpack/theme/app_sizes.dart';

class VulpackCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final String? dateRange;
  final VoidCallback? onTap;

  const VulpackCard({
    Key? key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.dateRange,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.textTertiary.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: TextStyle(
                  fontSize: AppSizes.textXl,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: AppSizes.sm),
              
              // Date range if provided
              if (dateRange != null)
                Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.sm),
                  child: Text(
                    dateRange!,
                    style: TextStyle(
                      fontSize: AppSizes.textSm,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              
              // Description
              Text(
                description,
                style: TextStyle(
                  fontSize: AppSizes.textSm,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              
              // Image if provided
              if (imageUrl != null) ...[
                SizedBox(height: AppSizes.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  child: Image.network(
                    imageUrl!,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                        ),
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.textTertiary,
                          size: 50,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}