import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/custom_text_field.dart';
import 'package:decommers/auth/SignIn/verificationPassword.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Reset Password',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF071221),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Masukan Email/ No. Hp akun untuk mereset kata sandi Anda',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.grey[500],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 60),
                const CustomTextField(
                  label: 'Email/ Phone',
                  hintText: 'Enter your email or phone',
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 50),
                // Prominent Reset Button
                Material(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(18),
                  elevation: 8,
                  shadowColor: primaryGreen.withOpacity(0.4),
                  child: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VerificationPasswordScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      alignment: Alignment.center,
                      child: Text(
                        'Reset',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
