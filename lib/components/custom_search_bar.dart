import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[600]),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Product Name',
                hintStyle: GoogleFonts.outfit(
                  color: Colors.grey[400],
                  fontSize: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.qr_code_scanner, color: Colors.grey[600]),
        ],
      ),
    );
  }
}
