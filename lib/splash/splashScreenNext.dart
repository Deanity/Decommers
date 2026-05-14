import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/unlogin/unLogin.dart';
import 'package:decommers/home/homePage.dart';
import 'package:decommers/services/auth_service.dart';

class SplashScreenNext extends StatelessWidget {
  const SplashScreenNext({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const primaryGreen = Color(0xFF5BC33C);
    final authService = AuthService();
    
    return Scaffold(
      backgroundColor: primaryGreen,
      body: Stack(
        children: [
          // Background Decorations (Subtle circles at the bottom)
          Positioned(
            bottom: -size.width * 0.3,
            left: -size.width * 0.2,
            child: Container(
              width: size.width * 0.9,
              height: size.width * 0.9,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 60,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.1,
            right: size.width * 0.2,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
          ),
          
          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Shopping Bag Icon with Smile and Sparkle
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 100,
                          color: Colors.white,
                        ),
                      ),
                      const Positioned(
                        right: 15,
                        top: 15,
                        child: Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Title
                  Text(
                    'Freebies',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 54,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),
                  // Subtitle
                  Text(
                    'E-Commerce',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Description
                  Text(
                    'Belanja gratis ongkir, diskon menarik, dan produk terbaik untuk kamu.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 16,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 80),
                  // "Mulai Belanja" Button
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        if (authService.currentUser != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const UnLoginScreen()),
                          );
                        }
                      },
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Mulai Belanja',
                              style: GoogleFonts.outfit(
                                color: primaryGreen,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.arrow_forward,
                              color: primaryGreen,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
