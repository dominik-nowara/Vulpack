import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String pageTitle = 'Home Page';

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
                context.go('/details');
              },
              child: const Text('Details'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.go('/profile');
              },
              child: const Text('Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/settings');
              },
              child: const Text('Settings'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/create');
              },
              child: const Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/design');
              },
              child: const Text('Design'),
            ),
          ],
        ),
      ),
    );
  }
}
