import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/custom_text_field.dart';
import 'package:decommers/auth/SignIn/verificationPassword.dart';
import 'package:decommers/components/toast_popup.dart';
import 'package:decommers/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    FocusScope.of(context).unfocus();
    
    if (_emailController.text.isEmpty) {
      ToastPopup.show(
        context,
        title: 'Warning',
        message: 'Mohon masukkan email Anda.',
        type: ToastType.warning,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.resetPassword(_emailController.text.trim());
      if (mounted) {
        ToastPopup.show(
          context,
          title: 'Success',
          message: 'Link reset password telah dikirim ke email Anda!',
          type: ToastType.success,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VerificationPasswordScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String errorMessage;
        if (e.code == 'user-not-found') {
          errorMessage = 'Email tidak terdaftar.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Format email tidak valid.';
        } else {
          errorMessage = 'Terjadi masalah pada server. Silakan coba beberapa saat lagi.';
        }

        ToastPopup.show(
          context,
          title: 'Reset Gagal',
          message: errorMessage,
          type: ToastType.error,
        );
      }
    } catch (e) {
      if (mounted) {
        ToastPopup.show(
          context,
          title: 'Error',
          message: 'Terjadi masalah pada server. Silakan coba beberapa saat lagi.',
          type: ToastType.error,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
                CustomTextField(
                  controller: _emailController,
                  label: 'Email/ Phone',
                  hintText: 'Enter your email or phone',
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 50),
                Material(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(18),
                  elevation: 8,
                  shadowColor: primaryGreen.withOpacity(0.4),
                  child: InkWell(
                    onTap: _isLoading ? null : _handleReset,
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      alignment: Alignment.center,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
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
