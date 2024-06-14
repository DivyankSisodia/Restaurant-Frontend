import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/services/getUserDetails.service.dart';

final fetchUserProvider = Provider<UserDetailsService>((ref) => UserDetailsService());

final getUserProvider = FutureProvider.autoDispose((ref) async {
  final userInfo = ref.read(fetchUserProvider);
  return userInfo.getUserDetails();
});