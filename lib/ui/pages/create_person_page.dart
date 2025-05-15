import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreatePersonPage extends StatelessWidget {
  const CreatePersonPage({super.key});

  @override
  Widget build(BuildContext context) {
    const String pageTitle = 'Create Person Page';

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
              child: const Text('Button 1'),
            ),
          ],
        ),
      ),
    );
  }
}
