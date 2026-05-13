import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/section_header.dart';
import 'package:decommers/components/product_card.dart';
import 'package:decommers/components/category_item.dart';
import 'package:decommers/components/news_item.dart';
import 'package:decommers/components/custom_search_bar.dart';
import 'package:decommers/auth/SignIn/signIn.dart';

class UnLoginScreen extends StatefulWidget {
  const UnLoginScreen({super.key});

  @override
  State<UnLoginScreen> createState() => _UnLoginScreenState();
}

class _UnLoginScreenState extends State<UnLoginScreen> {
  late PageController _pageController;
  final int _totalBanners = 3;

  void _showLoginModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle Bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Login Required',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF071221),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Color(0xFF071221)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(height: 1),
            const SizedBox(height: 30),
            // Waving Hand Illustration (Placeholder for 3D Icon)
            Container(
              padding: const EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     color: const Color(0xFF5BC33C).withOpacity(0.1),
            //     shape: BoxShape.circle,
            //   ),
              child: Image.asset(
                'assets/images/waving_hand_3d.png',
                height: 80,
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.touch_app_rounded, size: 80, color: Color(0xFF5BC33C)),
              ),
            ),
            const SizedBox(height: 30),
            // Message
            Text(
              'Oops! Anda Belum Login',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Silahkan login atau buat akun terlebih dahulu untuk mulai berbelanja di Freebies!',
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontSize: 15,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            // Login Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5BC33C),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Login Sekarang',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Sign Up link
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              child: Text(
                'Belum punya akun? Daftar Disini',
                style: GoogleFonts.outfit(
                  color: const Color(0xFF5BC33C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1000, viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF5BC33C);

    // List of banner data
    final List<Map<String, dynamic>> banners = [
      {
        'title': 'Special Offer\nFor Today!',
        'subtitle': 'LIMITED TIME',
        'colors': [primaryGreen, primaryGreen.withOpacity(0.8)],
        'icon': Icons.stars_rounded,
      },
      {
        'title': 'New Arrival\nTech Gadgets',
        'subtitle': 'NEW TECH',
        'colors': [const Color(0xFF2196F3), const Color(0xFF00BCD4)],
        'icon': Icons.devices,
      },
      {
        'title': 'Big Sale\nUp to 50%!',
        'subtitle': 'FLASH SALE',
        'colors': [const Color(0xFFFF5722), const Color(0xFFFF9800)],
        'icon': Icons.local_fire_department_rounded,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Freebies',
                style: GoogleFonts.outfit(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Your favorite marketplace',
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(top: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => _showLoginModal(context),
              icon: const Icon(Icons.notifications_outlined, color: Color(0xFF1A1A1A), size: 22),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, right: 20),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () => _showLoginModal(context),
              icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF1A1A1A), size: 22),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => _showLoginModal(context),
              child: AbsorbPointer(child: const CustomSearchBar()),
            ),
            const SizedBox(height: 15),
            
            // Infinite Premium Promo Banner Carousel
            SizedBox(
              height: 210,
              child: PageView.builder(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final bannerIndex = index % banners.length;
                  final banner = banners[bannerIndex];
                  return GestureDetector(
                    onTap: () => _showLoginModal(context),
                    child: _buildPromoBanner(
                      context,
                      title: banner['title'] as String,
                      subtitle: banner['subtitle'] as String,
                      colors: List<Color>.from(banner['colors'] as List),
                      icon: banner['icon'] as IconData,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),
            // Modern Categories
            SectionHeader(title: 'Categories', onSeeAll: () => _showLoginModal(context)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  GestureDetector(onTap: () => _showLoginModal(context), child: const CategoryItem(label: 'Fashion', icon: Icons.checkroom, color: Colors.orangeAccent)),
                  const SizedBox(width: 25),
                  GestureDetector(onTap: () => _showLoginModal(context), child: const CategoryItem(label: 'Electronic', icon: Icons.devices, color: Colors.blueAccent)),
                  const SizedBox(width: 25),
                  GestureDetector(onTap: () => _showLoginModal(context), child: const CategoryItem(label: 'Furniture', icon: Icons.chair, color: Colors.brown)),
                  const SizedBox(width: 25),
                  GestureDetector(onTap: () => _showLoginModal(context), child: const CategoryItem(label: 'Beauty', icon: Icons.face_retouching_natural, color: Colors.pinkAccent)),
                  const SizedBox(width: 25),
                  GestureDetector(onTap: () => _showLoginModal(context), child: const CategoryItem(label: 'Gadget', icon: Icons.smartphone, color: Colors.purpleAccent)),
                ],
              ),
            ),

            const SizedBox(height: 20),
            SectionHeader(title: 'Featured Product', onSeeAll: () => _showLoginModal(context)),
            
            // Featured Products Horizontal List
            SizedBox(
              height: 225,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  ProductCard(
                    title: 'TWS Airbuds Pro 2',
                    price: 'Rp 450.000',
                    rating: '4.8',
                    reviews: '124',
                    isSale: true,
                    onTap: () => _showLoginModal(context),
                    margin: const EdgeInsets.only(right: 15, bottom: 10),
                  ),
                  ProductCard(
                    title: 'Smart Watch Series 7',
                    price: 'Rp 850.000',
                    rating: '4.9',
                    reviews: '89',
                    onTap: () => _showLoginModal(context),
                    margin: const EdgeInsets.only(right: 15, bottom: 10),
                  ),
                  ProductCard(
                    title: 'Leather Wallet Brown',
                    price: 'Rp 150.000',
                    rating: '4.7',
                    reviews: '210',
                    onTap: () => _showLoginModal(context),
                    margin: const EdgeInsets.only(right: 15, bottom: 10),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // Modern Middle Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () => _showLoginModal(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.flash_on, color: Colors.orange, size: 28),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flash Sale!',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                            Text(
                              'Ends in 02:45:12',
                              style: GoogleFonts.outfit(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
            SectionHeader(title: 'Best Sellers', onSeeAll: () => _showLoginModal(context)),
            
            // Best Sellers Grid
            SizedBox(
              height: 225,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  ProductCard(
                    title: 'TWS Airbuds Pro 2',
                    price: 'Rp 450.000',
                    rating: '4.8',
                    reviews: '124',
                    onTap: () => _showLoginModal(context),
                    margin: const EdgeInsets.only(right: 15, bottom: 10),
                  ),
                  ProductCard(
                    title: 'Smart Watch Series 7',
                    price: 'Rp 850.000',
                    rating: '4.9',
                    reviews: '89',
                    onTap: () => _showLoginModal(context),
                    margin: const EdgeInsets.only(right: 15, bottom: 10),
                  ),
                  ProductCard(
                    title: 'Leather Wallet Brown',
                    price: 'Rp 150.000',
                    rating: '4.7',
                    reviews: '210',
                    onTap: () => _showLoginModal(context),
                    margin: const EdgeInsets.only(right: 15, bottom: 10),
                  ),
                  ProductCard(
                    title: 'Smart Phone Pro',
                    price: 'Rp 2.000.000',
                    rating: '4.9',
                    reviews: '150',
                    onTap: () => _showLoginModal(context),
                    margin: const EdgeInsets.only(right: 15, bottom: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryGreen,
          unselectedItemColor: Colors.grey[400],
          currentIndex: 0,
          onTap: (index) => _showLoginModal(context),
          selectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 12),
          unselectedLabelStyle: GoogleFonts.outfit(fontWeight: FontWeight.w500, fontSize: 12),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_filled, size: 26), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline, size: 26), label: 'Wishlist'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined, size: 26), label: 'Orders'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline_rounded, size: 26), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<Color> colors,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8), // Gap between slides
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 20,
              top: 20,
              child: Opacity(
                opacity: 0.15,
                child: Icon(icon, size: 80, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      subtitle,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: colors[0],
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    ),
                    child: Text(
                      'Claim Now',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
