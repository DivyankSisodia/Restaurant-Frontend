import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuHeadingText extends StatelessWidget {
  const MenuHeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 3.14 * 2.4,
              child: Image.asset(
                color: Colors.black87,
                'assets/logo/pngwing.com (1).png',
                height: 30,
              ),
            ),
            const Gap(5),
            Text(
              'Menu',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade600,
                fontFamily: GoogleFonts.poppins().fontFamily,
              ),
            ),
            const Gap(5),
            Transform.rotate(
              angle: 4.4,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/logo/pngwing.com (1).png',
                height: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
