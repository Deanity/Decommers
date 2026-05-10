import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/custom_text_field.dart';
import 'package:decommers/home/homePage.dart';

class RegisterAccountNamePasswordScreen extends StatelessWidget {
  const RegisterAccountNamePasswordScreen({super.key});

  void _showSuccessModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/success_illustration_3d.png',
                height: 150,
              ),
              const SizedBox(height: 30),
              Text(
                'Registration Success!',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF071221),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Akun Anda telah berhasil dibuat.\nSelamat bergabung di Freebies!',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Wait 3 seconds then navigate to Home (UnLogin for now or Login)
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF5BC33C);
    
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1A1A1A), size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Profile & Password',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF071221),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Lengkapi data terakhir berikut untuk masuk ke aplikasi Freebies',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 50),
                const CustomTextField(
                  label: 'Full Name',
                  hintText: 'Matias Duarte',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                const CustomTextField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  isPassword: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                    const SizedBox(width: 8),
                    Text(
                      'Kata sandi harus 6 karakter atau lebih',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const CustomTextField(
                  label: 'Referal Code (Optional)',
                  hintText: 'Input your code',
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 60),
                // Confirmation Button
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _showSuccessModal(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      elevation: 8,
                      shadowColor: primaryGreen.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Text(
                      'Confirmation',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
