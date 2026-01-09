//Package
import 'package:flutter/material.dart';

//Service
import './services/navigation_service.dart';

//Page
import './pages/splash_page.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(MainApp());
      },
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TraChat",
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
        ),
      ),
      // navigatorKey: NavigationService.navigatorKey,
    );
  }
}
