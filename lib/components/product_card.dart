import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String rating;
  final String reviews;
  final String? imageUrl;
  final bool isSale;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.rating,
    required this.reviews,
    this.imageUrl,
    this.isSale = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 165,
          height: 230, // Increased from 220 to fix overflow
          margin: const EdgeInsets.only(right: 15, bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // Slightly less rounded for compact look
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 110, // More proportional
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: imageUrl != null 
                          ? Image.asset(imageUrl!, fit: BoxFit.contain)
                          : const Icon(Icons.image, color: Colors.grey, size: 35),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 34,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF071221),
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF5BC33C),
                      ),
                    ),
                    const SizedBox(height: 10), // Fixed gap instead of Spacer
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          rating,
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '$reviews Reviews',
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isSale)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'SALE',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
