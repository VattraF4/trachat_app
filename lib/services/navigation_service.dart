import 'package:flutter/material.dart';

//Package
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void removeAnyNavigateToRoute(String rout) {
    navigatorKey.currentState?.popAndPushNamed(rout);
  }

  void navigateToRoute(String rout) {
    navigatorKey.currentState?.pushNamed(rout);
  }

  void navigateToPage(Widget page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (BuildContext context) => page),
    );
  }

  void goBack(){
    navigatorKey.currentState?.pop();
  }
}
