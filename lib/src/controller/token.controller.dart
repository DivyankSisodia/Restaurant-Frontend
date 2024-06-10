import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final tokenProvider = FutureProvider<String?>((ref) async {
  // Retrieve the token from SharedPreferences
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token');
});
