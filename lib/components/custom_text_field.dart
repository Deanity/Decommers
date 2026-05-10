import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.textInputAction,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            textInputAction: widget.textInputAction,
            onSubmitted: (value) {
              if (widget.textInputAction == TextInputAction.done) {
                FocusScope.of(context).unfocus();
              }
            },
            style: GoogleFonts.outfit(
              fontSize: 16,
              color: const Color(0xFF1A1A1A),
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: GoogleFonts.outfit(
                color: Colors.grey[400],
                fontSize: 16,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
