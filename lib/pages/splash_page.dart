import 'package:flutter/material.dart';
//Package
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

//Service
import '../services/navigation_service.dart';
import '../services/media_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/database_service.dart';

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
    Future.delayed(Duration(seconds: 3)).then((_) {
      _setup().then((_) => widget.onInitializationComplete());
    });
    
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

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerService();
  }

  void _registerService() {
    GetIt.instance.registerSingleton<NavigationService>(NavigationService());
    GetIt.instance.registerSingleton<MediaService>(MediaService());
    GetIt.instance.registerSingleton<CloudStorageService>(
      CloudStorageService(),
    );
    GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
  }
}
