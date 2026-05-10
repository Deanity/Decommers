import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/auth/SignIn/confirmPassword.dart';

class VerificationPasswordScreen extends StatelessWidget {
  const VerificationPasswordScreen({super.key});

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
                  'Verification',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF071221),
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      color: Colors.grey[500],
                      height: 1.5,
                    ),
                    children: [
                      const TextSpan(text: 'Kami telah mengirimkan kode verifikasi ke\n+628*******716 '),
                      TextSpan(
                        text: 'Ganti?',
                        style: GoogleFonts.outfit(
                          color: const Color(0xFF005696),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Verification Code',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    Text(
                      'Re-send Code',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF005696),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) => _buildOTPBox(context)),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kirim kode ulang dalam',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    Text(
                      '03:05',
                      style: GoogleFonts.outfit(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                // Continue Button
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
                        MaterialPageRoute(builder: (context) => const ConfirmPasswordScreen()),
                      );
                    },
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      alignment: Alignment.center,
                      child: Text(
                        'Continue',
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

  Widget _buildOTPBox(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
          decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
