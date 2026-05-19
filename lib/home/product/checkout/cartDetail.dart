import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/home/product/checkout/cartDelivery.dart';
import 'package:decommers/components/toast_popup.dart';

class CartDetailScreen extends StatelessWidget {
  const CartDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF5BC33C);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF071221), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cart',
          style: GoogleFonts.outfit(
            color: const Color(0xFF071221),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Color(0xFF071221)),
            onPressed: () {
              ToastPopup.show(
                context,
                title: 'Help',
                message: 'Silakan isi detail personal Anda dengan benar.',
                type: ToastType.info,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper
            _buildStepper(0),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total Items Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '4 Total Items',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: const Color(0xFF071221),
                              ),
                            ),
                            Text(
                              'Edit',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: primaryGreen,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            _buildItemThumbnail(Icons.headphones),
                            const SizedBox(width: 10),
                            _buildItemThumbnail(Icons.watch),
                            const SizedBox(width: 10),
                            _buildItemThumbnail(Icons.camera_alt),
                            const SizedBox(width: 10),
                            _buildItemThumbnail(Icons.smartphone),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'You saved Rp 150.000!',
                          style: GoogleFonts.outfit(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Rp 350.000',
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: const Color(0xFF071221),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Rp 500.000',
                                  style: GoogleFonts.outfit(
                                    fontSize: 14,
                                    color: Colors.grey[400],
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                ToastPopup.show(
                                  context,
                                  title: 'Kupon',
                                  message: 'Fitur kupon akan segera hadir!',
                                  type: ToastType.info,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: Text(
                                  'Coupon Available',
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF071221),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Personal Details Title
                  Row(
                    children: [
                      const Icon(Icons.person_outline, color: Colors.grey, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        'Personal Details',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color(0xFF071221),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Forms
                  _buildInputLabel('Full Name'),
                  _buildTextField(
                    hint: 'John Doe',
                    prefixIcon: Icons.person_outline,
                  ),

                  const SizedBox(height: 15),
                  _buildInputLabel('Email Address'),
                  _buildTextField(
                    hint: 'johndoe@gmail.com',
                    prefixIcon: Icons.mail_outline,
                  ),

                  const SizedBox(height: 15),
                  _buildInputLabel('Phone Number'),
                  _buildPhoneField(),

                  const SizedBox(height: 15),
                  _buildInputLabel('Country'),
                  _buildCountryField(),
                  
                  const SizedBox(height: 40),
                  
                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartDeliveryScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemThumbnail(IconData icon) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Icon(icon, color: Colors.grey, size: 24),
    );
  }

  Widget _buildStepper(int currentIndex) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          _buildStepSegment('User Detail', 0, currentIndex),
          _buildStepSegment('Delivery', 1, currentIndex),
          _buildStepSegment('Payment', 2, currentIndex),
        ],
      ),
    );
  }

  Widget _buildStepSegment(String label, int index, int currentIndex) {
    const primaryGreen = Color(0xFF5BC33C);
    bool isCompleted = index <= currentIndex;
    bool isActive = index == currentIndex;
    bool isNextCompleted = (index + 1) <= currentIndex;

    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              // Left line
              Expanded(
                child: Container(
                  height: 3,
                  color: isCompleted ? primaryGreen : Colors.grey[300],
                ),
              ),
              // Dot
              Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? primaryGreen : Colors.grey[300]!,
                    width: isActive ? 6 : 2,
                  ),
                ),
              ),
              // Right line
              Expanded(
                child: Container(
                  height: 3,
                  color: isNextCompleted ? primaryGreen : Colors.grey[300],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              color: isActive ? const Color(0xFF071221) : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF071221),
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint, required IconData prefixIcon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.outfit(color: Colors.grey[400], fontSize: 15),
          prefixIcon: Icon(prefixIcon, color: Colors.grey[500], size: 20),
          prefixIconConstraints: const BoxConstraints(minWidth: 35),
        ),
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          const Text('🇮🇩', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 5),
          const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 16),
          const SizedBox(width: 10),
          Container(height: 20, width: 1, color: Colors.grey[300]),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '+62 812-3456-7890',
                hintStyle: GoogleFonts.outfit(color: Colors.grey[400], fontSize: 15),
              ),
              keyboardType: TextInputType.phone,
            ),
          ),
          const Icon(Icons.help_outline, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildCountryField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          const Text('🇮🇩', style: TextStyle(fontSize: 20)),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Indonesia',
                hintStyle: GoogleFonts.outfit(color: Colors.grey[400], fontSize: 15),
              ),
              readOnly: true, // Only for display in this mock
            ),
          ),
          Text(
            'ID',
            style: GoogleFonts.outfit(
              color: const Color(0xFF071221),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.help_outline, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
