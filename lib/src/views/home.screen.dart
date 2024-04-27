// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/widgets/home/restaurant.dart';
import 'package:gap/gap.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/restaurant.controller.dart';
import '../widgets/common/heading_row.dart';
import '../widgets/common/promo_discount_coupon_img.dart';
import '../widgets/common/restaurant.grid.widget.dart';
import '../widgets/home/animated_searchBar.dart';
import '../widgets/common/category.dart';
import '../widgets/home/home_appbar.dart';
import '../widgets/home/promo_banner_slider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required this.token, required this.userData});

  final token;
  final userData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late String address;

  @override
  void initState() {
    super.initState();

    debugPrint('Token: ${(widget.userData)}');

    try {
      if (widget.token != null) {
        Map<String, dynamic> jwtDecodeToken = JwtDecoder.decode(widget.token!);
        debugPrint('Decoded token: $jwtDecodeToken');

        // Set address from widget.userData
        address = widget.userData != null && widget.userData['address'] != null
            ? widget.userData['address'][0] ?? 'Unknown'
            : 'Unknown';

        debugPrint('Address found: $address');
      } else {
        debugPrint('Token is null');
        address = 'Unknown';
      }
    } catch (e) {
      debugPrint('Error decoding token: $e');
      address = 'Unknown';
    }

    // Store address using SharedPreferences
    storeAddress(address);
  }

  // Function to store address using SharedPreferences
  Future<void> storeAddress(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_address', address);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: CustomScrollView(
          scrollBehavior: const CupertinoScrollBehavior(),
          slivers: [
            SliverAppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.white,
              floating: true,
              stretch: true,
              expandedHeight: height * 0.14,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      HomeAppBar(
                          height: height, width: width, address: address),
                      const Gap(10),
                      const AnimatedTextSearchBar(),
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: PromoBannerSlider(),
              ),
            ),
            SliverToBoxAdapter(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const HeadingRow(title: 'BEST OFFERS FOR YOU'),
                    const Gap(8),
                    PromoDiscountCoupons(height: height),
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Gap(8),
                      HeadingRow(title: 'WHAT\'S ON YOUR MIND?'),
                      Gap(12),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SizedBox(
                  height: height * 0.25,
                  child: const CategoryScreen(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Gap(8),
                      HeadingRow(title: 'ALL RESTAURANTS'),
                      Gap(8),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: Consumer(
                builder: (context, ref, child) {
                  final restaurantList = ref.watch(restaurantProvider);

                  // Calculate the child count based on the length of restaurantList
                  final childCount = restaurantList.maybeWhen(
                    data: (data) => data.length,
                    orElse: () => 0, // Default to 0 if data is null or loading
                  );

                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // Check if index exceeds childCount, if so, return null
                        if (index >= childCount) {
                          return null;
                        }
                        // If data is available, build the RestaurantGridWidget
                        return restaurantList.when(
                          data: (data) => RestaurantGridWidget(
                            image: data[index].imageUrl,
                            title: data[index].title,
                          ),
                          error: (error, stack) => const Center(
                            child: Text('Error'),
                          ),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                      childCount:
                          childCount, // Provide the calculated childCount
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
