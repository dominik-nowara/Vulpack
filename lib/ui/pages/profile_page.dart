import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String pageTitle = 'Profile Page';

    return Scaffold(
      appBar: AppBar(
        title: const Text(pageTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              pageTitle,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/person');
              },
              child: const Text('Person'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.go('/luggage');
              },
              child: const Text('Luggage'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.push('/items');
              },
              child: const Text('Items'),
            ),
          ],
        ),
      ),
    );
  }
}
