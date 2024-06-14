import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../utils/styles/text_style.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppStyle.mediumPriceText.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  const Gap(5),
                  Text(
                    subTitle,
                    style: AppStyle.cartScreenSmallText.copyWith(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
