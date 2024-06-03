// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../widgets/home/view/display.restaurant.widget.dart';
import '../widgets/home/view/banner.images.widget.dart';
import '../widgets/home/view/custom.appbar.dart';
import '../widgets/home/view/discount.coupons.dart';
import '../widgets/home/view/foodCategory.widget.dart';
import '../widgets/home/view/headings.title.widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    super.key,
    required this.token,
  });

  final token;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    try {
      if (widget.token != null) {
        Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token!);
        debugPrint('Decoded token: $jwtDecodeToken');
      } else {
        debugPrint('Token is null');
      }
    } catch (e) {
      debugPrint('Error decoding token: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          scrollBehavior: const CupertinoScrollBehavior(),
          slivers: [
            // Address and search bar
            CustomAppBar(height: height, width: width,),

            // Promo banner slider
            const BannerImages(),

            // Promo discount coupons
            DiscountCoupons(height: height),

            // Categories heading text
            const HomeScreenHeadingsTitle(title: 'WHAT\'S ON YOUR MIND?'),

            // Display food categories
            DisplayFoodCategoryWidget(height: height),

            // Restaurant heading text
            const HomeScreenHeadingsTitle(title: 'ALL RESTAURANTS'),

            // display restaurants
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              sliver: DisplayRestaurantsWidget(),
            ),

            const SliverToBoxAdapter(
              child: Gap(20.0),
            ),
          ],
        ),
      ),
    );
  }
}
