import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({required Key key, required this.onInitializationComplete})
    : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TraChat",
      theme: ThemeData(
        useMaterial3: true, // ← ADD THIS LINE
        scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
        // backgroundColor: Color.fromRGBO(36, 25, 49, 1.0),  // Should work now
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/chat_icon.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
