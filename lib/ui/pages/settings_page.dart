import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String pageTitle = 'Settings Page';

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
                context.go('/home');
              },
              child: const Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}
