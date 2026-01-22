//Package
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Service
import './services/navigation_service.dart';

//Provider
import '../provider/authenticator_provider.dart';

//Page
import './pages/splash_page.dart';
import './pages/login_page.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticatorProvider>(
          create: (BuildContext context) {
            return AuthenticatorProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: "TraChat",
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {'/login': (BuildContext context) => LoginPage()},
      ),
    );
  }
}
