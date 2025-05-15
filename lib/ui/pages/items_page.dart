import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String pageTitle = 'Items Page';

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
                context.go('/create-items');
              },
              child: const Text('Create Items'),
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
