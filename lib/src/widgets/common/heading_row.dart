import 'package:flutter/material.dart';
import 'package:food_delivery/src/widgets/common/heading_text.dart';
import 'package:gap/gap.dart';

class HeadingRow extends StatelessWidget {
  const HeadingRow({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          HeadingText(title: title),
          const Gap(15),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.grey[400]!,
                    Colors.grey[300]!,
                    Colors.grey[100]!,
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
