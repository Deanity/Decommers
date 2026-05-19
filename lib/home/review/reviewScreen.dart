import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF071221), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Review Product',
          style: GoogleFonts.outfit(
            color: const Color(0xFF071221),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                '4.6',
                style: GoogleFonts.outfit(
                  color: const Color(0xFF071221),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 24),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Rating Overview
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side
                  Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '4.6',
                              style: GoogleFonts.outfit(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF071221),
                              ),
                            ),
                            TextSpan(
                              text: '/5',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '86 Reviews',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  // Divider
                  Container(
                    height: 100,
                    width: 1,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(width: 20),
                  // Right Side (Bars)
                  Expanded(
                    child: Column(
                      children: [
                        _buildRatingBar(5, 70, 0.8),
                        const SizedBox(height: 5),
                        _buildRatingBar(4, 5, 0.1),
                        const SizedBox(height: 5),
                        _buildRatingBar(3, 8, 0.15),
                        const SizedBox(height: 5),
                        _buildRatingBar(2, 2, 0.05),
                        const SizedBox(height: 5),
                        _buildRatingBar(1, 1, 0.02),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Reviews List
              _buildReviewItem(
                name: 'Yelena Belova',
                time: '2 Minggu yang lalu',
                rating: 4,
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildReviewItem(
                name: 'Stephen Strange',
                time: '1 Bulan yang lalu',
                rating: 3,
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildReviewItem(
                name: 'Peter Parker',
                time: '2 Bulan yang lalu',
                rating: 4,
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildReviewItem(
                name: 'T\'chala',
                time: '1 Bulan yang lalu',
                rating: 3,
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildReviewItem(
                name: 'Tony Stark',
                time: '2 Bulan yang lalu',
                rating: 5,
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildReviewItem(
                name: 'Peter Quil',
                time: '1 Bulan yang lalu',
                rating: 4,
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
              _buildReviewItem(
                name: 'Wanda Maximof',
                time: '2 Bulan yang lalu',
                rating: 5,
                text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingBar(int stars, int count, double percentage) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < stars ? Icons.star : Icons.star_border,
              color: index < stars ? Colors.amber : Colors.grey[300],
              size: 14,
            );
          }),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
              minHeight: 6,
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 20,
          child: Text(
            count.toString(),
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: const Color(0xFF071221),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewItem({
    required String name,
    required String time,
    required int rating,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar Placeholder
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: const Color(0xFF071221),
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: index < rating ? Colors.amber : Colors.grey[300],
                      size: 14,
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
