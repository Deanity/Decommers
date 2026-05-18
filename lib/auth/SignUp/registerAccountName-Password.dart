import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/components/custom_text_field.dart';
import 'package:decommers/home/homePage.dart';
import 'package:decommers/services/auth_service.dart';
import 'package:decommers/components/toast_popup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterAccountNamePasswordScreen extends StatefulWidget {
  final String email;
  const RegisterAccountNamePasswordScreen({super.key, required this.email});

  @override
  State<RegisterAccountNamePasswordScreen> createState() => _RegisterAccountNamePasswordScreenState();
}

class _RegisterAccountNamePasswordScreenState extends State<RegisterAccountNamePasswordScreen> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _referralController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_nameController.text.isEmpty || _passwordController.text.isEmpty) {
      ToastPopup.show(
        context,
        title: 'Warning',
        message: 'Please fill in all required fields',
        type: ToastType.warning,
      );
      return;
    }

    if (_passwordController.text.length < 6) {
      ToastPopup.show(
        context,
        title: 'Warning',
        message: 'Password must be at least 6 characters',
        type: ToastType.warning,
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _authService.register(
        email: widget.email,
        password: _passwordController.text.trim(),
        fullName: _nameController.text.trim(),
        referralCode: _referralController.text.trim().isEmpty ? null : _referralController.text.trim(),
      );
      if (mounted) {
        _showSuccessModal(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        String errorMessage;
        if (e.code == 'weak-password') {
          errorMessage = 'Kata sandi terlalu lemah.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'Akun dengan email ini sudah ada.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Format email tidak valid.';
        } else {
          errorMessage = 'Terjadi masalah pada server. Silakan coba beberapa saat lagi.';
        }

        ToastPopup.show(
          context,
          title: 'Registrasi Gagal',
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
                errorBuilder: (context, error, stackTrace) => 
                  const Icon(Icons.check_circle, size: 100, color: Color(0xFF5BC33C)),
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
                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hintText: 'Matias Duarte',
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  controller: _passwordController,
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
                CustomTextField(
                  controller: _referralController,
                  label: 'Referal Code (Optional)',
                  hintText: 'Input your code',
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      elevation: 8,
                      shadowColor: primaryGreen.withOpacity(0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
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
