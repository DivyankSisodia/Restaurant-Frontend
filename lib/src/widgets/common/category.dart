import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../controller/animtaion.controller.dart';
import '../../controller/category.controller.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final categoryAnimation = ref.watch(animationStateProvider);
        final foodList = ref.watch(categoriesProvider);
        return foodList.when(
          data: (data) => MasonryGridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 130,
                child: categoryAnimation
                    ? Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            backgroundImage:
                                CachedNetworkImageProvider(data[index].image),
                          ),
                          const Gap(5),
                          Text(
                            data[index].title,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      )
                    : SlideInLeft(
                        duration: const Duration(milliseconds: 500),
                        delay: Duration(milliseconds: 50 * index),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              backgroundImage:
                                  CachedNetworkImageProvider(data[index].image),
                            ),
                            const Gap(5),
                            Text(
                              data[index].title,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
              );
            },
          ),
          error: (error, stack) => const Center(
            child: Text('Error'),
          ),
          loading: () => Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: MasonryGridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: 3, // Number of shimmer items
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 130,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 30,
                      ),
                      const Gap(5),
                      Container(
                        width: 80,
                        height: 15,
                        color: Colors.white,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
