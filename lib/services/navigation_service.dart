import 'package:flutter/material.dart';

//Package
class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void removeAnyNavigateToRoute(String _rout) {
    navigatorKey.currentState?.popAndPushNamed(_rout);
  }

  void navigateToRoute(String _rout) {
    navigatorKey.currentState?.pushNamed(_rout);
  }

  void navigateToPage(Widget _page) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (BuildContext _context) => _page),
    );
  }

  void goBack(){
    navigatorKey.currentState?.pop();
  }
}
