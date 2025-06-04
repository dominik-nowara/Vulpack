import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vulpack/ui/pages/widgets.dart';
import 'package:vulpack/ui/pages/theme/app_colors.dart';

class LuggagePage extends StatelessWidget {
  const LuggagePage({super.key});

  final List<String> luggageItems = const [
    '🧳 grey suitcase',
    '🎒 Trekking backpack',
    '👜 Purse',
    '🎒 Backpack',
    '🛼 roller bag',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBarWithAdd(
        title: 'Luggage',
        addButtonRoute: '/create-luggage',
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: luggageItems.length,
        itemBuilder: (context, index) {
          return _buildLuggageCard(luggageItems[index]);
        },
      ),
    );
  }

  Widget _buildLuggageCard(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: AppColors.black,
        ),
      ),
    );
  }
}