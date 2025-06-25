import 'package:eperumahan_bancian/config/constants/app_images.dart';
import 'package:flutter/material.dart';

class SearchAppbar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final void Function()? onTap;

  const SearchAppbar(
      {super.key, this.searchController, this.onSearchChanged, this.onTap});

  @override
  Size get preferredSize => const Size.fromHeight(140);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppImages.greenBg.path), fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          // Top Row: Logo and Menu Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo
              Row(
                children: [
                  const Icon(Icons.apartment, color: Colors.white, size: 28),
                  const SizedBox(width: 4),
                  Text(
                    "Carian Rumah",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Search Box
          TextFormField(
            onTap: onTap,
            readOnly: true,
            controller: searchController,
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              hintText: "Search",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.black, width: 2),
              ),
            ),
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
