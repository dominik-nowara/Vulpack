import 'package:flutter/material.dart';
import 'package:vulpack/pages/home_page.dart';
import 'package:vulpack/services/navigation/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router, // Use the router from the navigation file
    );
  }
}

