import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/custom_text_field.dart';

import 'package:decommers/auth/SignIn/signIn.dart';

class ConfirmPasswordScreen extends StatelessWidget {
  const ConfirmPasswordScreen({super.key});

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
                'Success Update Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF071221),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Kata sandi Anda telah berhasil diperbarui.\nSilakan login kembali.',
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

    // Wait 3 seconds then navigate to SignInScreen
    Future.delayed(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
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
                  'Update Password',
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
                const SizedBox(height: 60),
                const CustomTextField(
                  label: 'New Password',
                  hintText: 'Enter new password',
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
                  label: 'Confirm New Password',
                  hintText: 'Confirm your password',
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 60),
                // Save Update Button
                Material(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(18),
                  elevation: 8,
                  shadowColor: primaryGreen.withOpacity(0.4),
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      _showSuccessModal(context);
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      alignment: Alignment.center,
                      child: Text(
                        'Save Update',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
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
