import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ToastType { success, error, warning, info }

class ToastPopup {
  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required ToastType type,
  }) {
    Color backgroundColor;
    IconData icon;
    Color iconColor = Colors.white;

    switch (type) {
      case ToastType.success:
        backgroundColor = const Color(0xFF5BC33C); // Tema Hijau Primary
        icon = Icons.check_circle_outline;
        break;
      case ToastType.error:
        backgroundColor = Colors.redAccent;
        icon = Icons.error_outline;
        break;
      case ToastType.warning:
        backgroundColor = Colors.orangeAccent;
        icon = Icons.warning_amber_rounded;
        break;
      case ToastType.info:
        backgroundColor = Colors.blueAccent;
        icon = Icons.info_outline;
        break;
    }

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: backgroundColor.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    style: GoogleFonts.outfit(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
    );

    // Menyembunyikan snackbar yang sedang aktif sebelumnya agar tidak bertumpuk
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
