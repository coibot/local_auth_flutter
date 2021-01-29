import 'package:flutter/material.dart';
import 'package:local_auth_flutter/screens/auth/login_screen.dart';
import 'package:local_auth_flutter/screens/auth/splash_service_screen.dart';
import 'package:local_auth_flutter/services/shared_preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.init();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashServiceView(),
    );
  }
}


