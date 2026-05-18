import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/product_card.dart';
import 'package:decommers/home/product/detailProduct.dart';
import 'package:decommers/home/product/cartProduct.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Wishlist',
          style: GoogleFonts.outfit(
            color: const Color(0xFF071221),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF071221)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartProductScreen()));
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return ProductCard(
            title: 'TMA-2 HD Wireless',
            price: 'Rp. 1.500.000',
            rating: '4.6',
            reviews: '86',
            isSale: index == 0 || index == 3,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailProduct()));
            },
          );
        },
      ),
    );
  }
}
