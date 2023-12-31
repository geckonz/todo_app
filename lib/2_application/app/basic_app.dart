import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/2_application/core/routes.dart';

// Home page: Navigation with two entry points
// - Overview
// - dashboard

class BasicApp extends StatelessWidget {
  const BasicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Todo App',
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      themeMode: ThemeMode.system,
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
//          colorScheme: const ColorScheme.light(),
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.purple,
        //   brightness: Brightness.light,
        // ),
      ),
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
//          colorScheme: const ColorScheme.dark(),
        // colorScheme: ColorScheme.fromSeed(
        //   seedColor: Colors.purple,
        //   brightness: Brightness.dark,
        // ),
      ),
      routerConfig: routes,
    );
  }
}
