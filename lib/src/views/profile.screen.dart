// ignore_for_file: unused_result

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/utils/styles/text_style.dart';
import 'package:food_delivery/src/views/login.screen.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/fetchUserDetail.controller.dart';
import '../widgets/profile/view/address.screen.dart';
import '../widgets/profile/view/orderHistory.dart';
import '../widgets/profile/view/user-detail.widget.dart';
import '../widgets/profile/widgets/profile-card.widget.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  // Function to refresh the page
  Future<void> _refreshPage() async {
    //  refetching user details from the server
    await ref.refresh(getUserProvider.future);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.15),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: const Text(
              'Help',
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPage,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const UserProfileScreen(),
                  const Gap(15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: w,
                      height: 3,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                  const Gap(10),
                  const ProfileCardWidget(
                    title: 'My Account',
                    subTitle: 'Favourite, Hidden Restaurants',
                  ),
                  const Gap(10),
                  LineWidget(w),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OrderHistoryScreen(),
                        ),
                      );
                    },
                    child: const ProfileCardWidget(
                      title: 'My Orders',
                      subTitle: 'Check your order History',
                    ),
                  ),
                  const Gap(10),
                  LineWidget(w),
                  const Gap(10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const AddressPasswordDialog();
                        },
                      );
                    },
                    child: const ProfileCardWidget(
                      title: 'Address & Password',
                      subTitle: 'Edit, Add or Remove Address & Password',
                    ),
                  ),
                  const Gap(10),
                  LineWidget(w),
                  const Gap(10),
                  const ProfileCardWidget(
                    title: 'Payments & Refunds',
                    subTitle: 'Refund Status & Payment Methods',
                  ),
                  const Gap(10),
                  LineWidget(w),
                  const Gap(10),
                  const ProfileCardWidget(
                    title: 'Settings',
                    subTitle: 'Theme, Language, Notifications',
                  ),
                  const Gap(10),
                  LineWidget(w),
                  const Gap(10),
                  InkWell(
                    onTap: () {
                      // ignore: avoid_print
                      SharedPreferences.getInstance().then((value) {
                        value.clear();
                      });
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                        (route) => false,
                      );
                      print('Logout');
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Logout',
                              style: AppStyle.mediumPriceText.copyWith(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Padding LineWidget(double w) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 7,
      ),
      child: Container(
        width: w,
        height: 1,
        color: Colors.grey.withOpacity(0.4),
      ),
    );
  }
}
