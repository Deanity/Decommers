import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/custom_text_field.dart';

import 'package:decommers/auth/SignIn/resetPassword.dart';
import 'package:decommers/auth/SignUp/registerAccountEmail.dart';
import 'package:decommers/home/homePage.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 60), // Pushing content down for better thumb reach
                        Text(
                          'Welcome back to\nFreebies',
                          style: GoogleFonts.outfit(
                            fontSize: 32, // Slightly larger title
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF071221),
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Silahkan masukan data untuk login',
                          style: GoogleFonts.outfit(
                            fontSize: 16,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(height: 60),
                        const CustomTextField(
                          label: 'Email/ Phone',
                          hintText: 'Enter your email or phone',
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 25),
                        const CustomTextField(
                          label: 'Password',
                          hintText: 'Enter your password',
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 50),
                        // Prominent Sign In Button
                        Material(
                          color: primaryGreen,
                          borderRadius: BorderRadius.circular(18),
                          elevation: 8,
                          shadowColor: primaryGreen.withOpacity(0.4),
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => const HomePage()),
                                (route) => false,
                              );
                            },
                            borderRadius: BorderRadius.circular(18),
                            child: Container(
                              width: double.infinity,
                              height: 65, // Taller button for better tap target
                              alignment: Alignment.center,
                              child: Text(
                                'Sign In',
                                style: GoogleFonts.outfit(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ResetPasswordScreen()),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                'Forgot Password',
                                style: GoogleFonts.outfit(
                                  color: const Color(0xFF1A1A1A),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const RegisterAccountEmailScreen()),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                'Sign Up',
                                style: GoogleFonts.outfit(
                                  color: primaryGreen, // Changed to green for consistency
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
