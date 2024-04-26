import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/views/login.screen.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/views/home.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString('token');
  String? address = pref.getString('user_address');
  runApp(ProviderScope(child: MyApp(token: token, initialAddress: address)));
}

class MyApp extends StatelessWidget {
  final String? token;
  final String? initialAddress;

  const MyApp({
    super.key,
    required this.token,
    this.initialAddress,
  });

  @override
  Widget build(BuildContext context) {
    // debugPrint('Token: $token');
    return MaterialApp(
      title: 'Your App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (token != null && JwtDecoder.isExpired(token!) == false)
          ? HomeScreen(token: token, userData: {
              'address': [initialAddress]
            })
          : const LoginScreen(),
    );
  }
}
