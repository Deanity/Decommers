import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final String? imageUrl;

  const NewsItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.date,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.outfit(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  date,
                  style: GoogleFonts.outfit(
                    fontSize: 11,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Container(
            width: 90,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            child: imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(imageUrl!, fit: BoxFit.cover),
                )
              : const Icon(Icons.article, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
