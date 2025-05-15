import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonPage extends StatelessWidget {
  const PersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String pageTitle = 'Person Page';

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
                context.go('/create-person');
              },
              child: const Text('Create Person'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
