import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

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
    double height = MediaQuery.of(context).size.height;
    return SliverAppBar(
      expandedHeight: height * 0.1,
      elevation: 5,
      floating: true,
      stretch: true,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
              bottom: 10,
            ),
            color: Colors.white,
            child: Center(
              child: TextFormField(
                controller: widget.controller,
                cursorColor: Colors.grey[400],
                onChanged: widget.onChanged,
                onTap: widget.onSearch,
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.2),
                  hintText: 'Search for dishes...',
                  hintStyle: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: GoogleFonts.poppins().fontFamily,
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
        ),
      ),
    );
  }
}
