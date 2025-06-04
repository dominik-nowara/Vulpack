import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vulpack/ui/pages/widgets.dart';
import 'package:vulpack/ui/pages/theme/app_colors.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  final List<Map<String, String>> people = const [
    {
      'name': 'John',
      'image': 'assets/images/john.jpg', // Pfad zu deinem Bild
    },
    {
      'name': 'Tania',
      'image': 'assets/images/tania.jpg',
    },
    {
      'name': 'Gerald',
      'image': 'assets/images/gerald.jpg',
    },
    {
      'name': 'Timmy',
      'image': 'assets/images/timmy.jpg',
    },
    {
      'name': 'Kevin',
      'image': 'assets/images/kevin.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBarWithAdd(
        title: 'People',
        addButtonRoute: '/create-person',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: people.length,
          itemBuilder: (context, index) {
            return _buildPersonCard(people[index]);
          },
        ),
      ),
    );
  }

  Widget _buildPersonCard(Map<String, String> person) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.lightGrey,
            ),
            child: ClipOval(
              child: Image.asset(
                person['image']!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback wenn Bild nicht gefunden wird
                  return Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.lightGrey,
                    ),
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            person['name']!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}