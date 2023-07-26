import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'go_router_observer.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root_navigator');

final routes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home/start',
  observers: [
    GoRouterObserver(),
  ],
  routes: [
    GoRoute(
      path: '/home/settings',
      builder: (context, state) {
        return Column(
          children: [
            Container(
              color: Colors.amber,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/home/start');
                },
                child: const Text('Go to Start'),
              ),
            ),
            TextButton(
               onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push('/home/start');
                  }
               },
              child: const Text('Go back'),
            ),
          ],
        );
      },
    ),
    GoRoute(
      path: '/home/start',
      builder: (context, state) {
        return Container(
          color: Colors.blueGrey,
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push('/home/settings');
                },
                child: const Text('Go to Settings'),
              ),
              TextButton(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.push('/home/settings');
                  }
                },
                child: const Text('Go back'),
              ),
            ],
          ),
        );
      },
    ),
  ],
);
