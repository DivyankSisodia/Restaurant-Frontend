import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery/src/utils/styles/text_style.dart';
import 'package:food_delivery/src/widgets/common/dot.separator.widget.dart';
import 'package:food_delivery/src/widgets/profile/view/edit-user-detail-screen.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../../../controller/fetchUserDetail.controller.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(getUserProvider);

    return Container(
      child: userData.when(
        data: (user) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    user.userName,
                    style: AppStyle.mediumPriceText,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const EditUserDetailDialog(),
                      );
                    },
                    child: const Icon(Iconsax.edit),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '+91 ${user.phone}',
                    style: AppStyle.cartScreenSmallText,
                  ),
                  const Gap(5),
                  const DotSeparatorWidget(),
                  const Gap(5),
                  Text(
                    user.email,
                    style: AppStyle.cartScreenSmallText,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(height: 5),
              if (user.address.isNotEmpty)
                Text(
                  user.address.join(', '),
                  style: AppStyle.cartScreenSmallestText.copyWith(
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load user details: $error'),
        ),
      ),
    );
  }
}


// Center(
//                 child: CachedNetworkImage(
//                   imageUrl: user.profile,
//                   placeholder: (context, url) =>
//                       const CircularProgressIndicator(),
//                   errorWidget: (context, url, error) => const Icon(Icons.error),
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                 ),
//               ),