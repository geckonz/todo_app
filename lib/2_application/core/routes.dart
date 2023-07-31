import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/2_application/pages/home/home_pages.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root_navigator');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell_navigator');

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home/dashboard',
  observers: [
    GoRouterObserver(),
  ],
  routes: [
    GoRoute(
      path: '/home/settings',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          path: '/home/:tab',
          builder: (context, state) => HomePage(
            key: state.pageKey,
            tab: state.pathParameters['tab']!,
          ),
        ),
      ],
    ),
  ],
);
