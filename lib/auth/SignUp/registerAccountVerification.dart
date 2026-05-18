import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/auth/SignUp/registerAccountName-Password.dart';
import 'package:decommers/components/toast_popup.dart';

class RegisterAccountVerificationScreen extends StatefulWidget {
  final String email;
  const RegisterAccountVerificationScreen({super.key, required this.email});

  @override
  State<RegisterAccountVerificationScreen> createState() => _RegisterAccountVerificationScreenState();
}

class _RegisterAccountVerificationScreenState extends State<RegisterAccountVerificationScreen> {
  final List<TextEditingController> _otpControllers = List.generate(4, (index) => TextEditingController());
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleVerify() async {
    FocusScope.of(context).unfocus();

    String otp = _otpControllers.map((c) => c.text).join();
    
    if (otp.length < 4) {
      ToastPopup.show(
        context,
        title: 'Warning',
        message: 'Mohon masukkan 4 digit kode OTP',
        type: ToastType.warning,
      );
      return;
    }

    setState(() => _isLoading = true);

    // Mock API call delay
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() => _isLoading = false);
      // Mock validation
      if (otp != '1234') { 
        ToastPopup.show(
          context,
          title: 'Error',
          message: 'Kode OTP yang Anda masukkan salah',
          type: ToastType.error,
        );
      } else {
        ToastPopup.show(
          context,
          title: 'Verified',
          message: 'Kode berhasil diverifikasi!',
          type: ToastType.success,
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterAccountNamePasswordScreen(email: widget.email)),
        );
      }
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
                      TextSpan(text: 'Kami telah mengirimkan kode verifikasi ke\n${widget.email} '),
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
                    GestureDetector(
                      onTap: () {
                        ToastPopup.show(
                          context,
                          title: 'Sent',
                          message: 'A new code has been sent.',
                          type: ToastType.success,
                        );
                      },
                      child: Text(
                        'Re-send Code',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF005696),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (index) => _buildOTPBox(context, index)),
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
                Material(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(18),
                  elevation: 8,
                  shadowColor: primaryGreen.withOpacity(0.4),
                  child: InkWell(
                    onTap: _isLoading ? null : _handleVerify,
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      alignment: Alignment.center,
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
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

  Widget _buildOTPBox(BuildContext context, int index) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: TextField(
          controller: _otpControllers[index],
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
            if (value.length == 1 && index < 3) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty && index > 0) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
