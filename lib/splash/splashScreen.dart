import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/unlogin/unLogin.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const primaryGreen = Color(0xFF5BC33C); // Vibrant green from the image
    
    return Scaffold(
      backgroundColor: primaryGreen,
      body: Stack(
        children: [
          // Background Decorations (Subtle circles)
          Positioned(
            bottom: -size.width * 0.2,
            left: -size.width * 0.2,
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withOpacity(0.15),
                  width: 50,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.15,
            right: size.width * 0.15,
            child: Container(
              width: 60,
              height: 60,
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
                  // Title
                  Text(
                    'Freebies',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 58,
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
                  const SizedBox(height: 35),
                  // Description
                  SizedBox(
                    width: size.width * 0.7,
                    child: Text(
                      'Belanja gratis ongkir, diskon menarik, dan produk terbaik untuk kamu.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        color: Colors.white.withOpacity(0.95),
                        fontSize: 16,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  // Button
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(45),
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(0.3),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const UnLoginScreen()),
                        );
                      },
                      borderRadius: BorderRadius.circular(45),
                      splashColor: primaryGreen.withOpacity(0.15),
                      highlightColor: primaryGreen.withOpacity(0.05),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 22),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Mulai Belanja',
                              style: GoogleFonts.outfit(
                                color: primaryGreen,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.arrow_forward,
                              color: primaryGreen,
                              size: 24,
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
