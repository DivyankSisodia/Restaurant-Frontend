import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/bottom_navbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString('token');
  await Hive.initFlutter();
  await Hive.openBox('user_info');
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
  runApp(
    ProviderScope(
      child: MyApp(
        token: token,
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  final String? token;

  const MyApp({
    super.key,
    required this.token,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('Token: $token');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const CustomBottomNavBar(),
    );
  }
}
