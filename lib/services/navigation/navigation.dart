import 'package:go_router/go_router.dart';
import 'package:vulpack/ui/pages/category_page.dart';
import 'package:vulpack/ui/pages/create_items_page.dart';
import 'package:vulpack/ui/pages/create_luggage_page.dart';
import 'package:vulpack/ui/pages/create_page.dart';
import 'package:vulpack/ui/pages/create_person_page.dart';
import 'package:vulpack/ui/pages/deatils_page.dart';
import 'package:vulpack/ui/pages/destination_page.dart';
import 'package:vulpack/ui/pages/home_page.dart';
import 'package:vulpack/ui/pages/activities_page.dart';
import 'package:vulpack/ui/pages/items_page.dart';
import 'package:vulpack/ui/pages/luggage_page.dart';
import 'package:vulpack/ui/pages/person_page.dart';
import 'package:vulpack/ui/pages/profile_page.dart';
import 'package:vulpack/ui/pages/settings_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => CreatePage(),
    ),
    GoRoute(
      path: '/activities',
      builder: (context, state) => ActivitesPage(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => CategoriesPage(),
    ),
    GoRoute(
      path: '/create-items',
      builder: (context, state) => CreateItemsPage(),
    ),
    GoRoute(
      path: '/create-luggage',
      builder: (context, state) => CreateLuggagePage(),
    ),
    GoRoute(
      path: '/create-person',
      builder: (context, state) => CreatePersonPage(),
    ),
    GoRoute(
      path: '/details',
      builder: (context, state) => DetailsPage(),
    ),
    GoRoute(
      path: '/destination',
      builder: (context, state) => DestinationPage(),
    ),
    GoRoute(
      path: '/items',
      builder: (context, state) => ItemsPage(),
    ),
    GoRoute(
      path: '/luggage',
      builder: (context, state) => LuggagePage(),
    ),
    GoRoute(
      path: '/person',
      builder: (context, state) => PersonPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfilePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => SettingsPage(),
    ),
  ],
);