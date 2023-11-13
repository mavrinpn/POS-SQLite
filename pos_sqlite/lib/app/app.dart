import 'package:flutter/material.dart';
import 'package:pos_sqlite/app/go_router.dart';
import 'package:pos_sqlite/presentation/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'POS test app',
      routerConfig: goRouter(),
      theme: AppTheme.getThemeFor(ThemeMode.light),
      darkTheme: AppTheme.getThemeFor(ThemeMode.dark),
      themeMode: ThemeMode.system,
    );
  }
}
