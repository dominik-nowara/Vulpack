import 'package:go_router/go_router.dart';
import 'package:vulpack/pages/create_page.dart';
import 'package:vulpack/pages/home_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(title: 'Flutter Demo Home Page'),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => CreatePage(title: 'Create Page'),
    ),
  ],
);