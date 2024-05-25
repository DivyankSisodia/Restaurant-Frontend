import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

import '../../../views/search.screen.dart';

class FoodSearchBar extends StatefulWidget {
  const FoodSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onSearch,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final VoidCallback? onSearch;

  @override
  State<FoodSearchBar> createState() => _FoodSearchBarState();
}

class _FoodSearchBarState extends State<FoodSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      pinned: true,
      // floating: true,
      // stretch: true,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(10),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Center(
                child: TextFormField(
                  controller: widget.controller,
                  cursorColor: Colors.grey[400],
                  onChanged: widget.onChanged,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(milliseconds: 900),
                        reverseDuration: const Duration(milliseconds: 700),
                        type: PageTransitionType.leftToRightWithFade,
                        child: const FoodSearchScreen(),
                      ),
                    );
                  },
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.withOpacity(0.2),
                    hintText: 'Search for dishes...',
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      fontFamily: GoogleFonts.dmSans().fontFamily,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                    ),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: widget.onSearch,
                          icon: Icon(
                            Iconsax.search_favorite,
                            color: Colors.grey[800],
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.grey[600],
                        ),
                        IconButton(
                          onPressed: () {
                            // Handle mic icon press
                          },
                          icon: const Icon(
                            CupertinoIcons.mic_solid,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
