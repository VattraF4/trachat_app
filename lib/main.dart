import 'package:flutter/material.dart';

//Package
import 'package:firebase_analytics/firebase_analytics.dart';

//Page
import './pages/splash_page.dart';

void main() {
  runApp(SplashPage(key: UniqueKey(), onInitializationComplete: () {}));
}
