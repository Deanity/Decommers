import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/custom_text_field.dart';
import 'package:decommers/auth/SignIn/signIn.dart';
import 'package:decommers/auth/SignUp/registerAccountVerification.dart';

class RegisterAccountEmailScreen extends StatelessWidget {
  const RegisterAccountEmailScreen({super.key});

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
                  'Register Account',
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF071221),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Masukan Email/ No. Hp untuk mendaftar',
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: Colors.grey[500],
                  ),
                ),
                const SizedBox(height: 60),
                const CustomTextField(
                  label: 'Email/ Phone',
                  hintText: 'Enter your email or phone',
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterAccountVerificationScreen(),
                        ),
                      );
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
                      'Continue',
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an Account? ',
                      style: GoogleFonts.outfit(
                        color: const Color(0xFF1A1A1A),
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.outfit(
                          color: primaryGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
