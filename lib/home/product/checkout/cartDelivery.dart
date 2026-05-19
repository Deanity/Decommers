import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/home/product/checkout/cartPayment.dart';
import 'package:decommers/components/toast_popup.dart';

class CartDeliveryScreen extends StatelessWidget {
  const CartDeliveryScreen({super.key});

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
          'Delivery',
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
                message: 'Pilih opsi pengiriman yang paling sesuai untuk Anda.',
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
            // Stepper (Index 1 = Delivery)
            _buildStepper(1),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Delivery Details Title
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, color: Colors.grey, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        'Delivery Address',
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
                  _buildInputLabel('Street Address'),
                  _buildTextField(
                    hint: 'Jl. Sudirman No. 123',
                    prefixIcon: Icons.home_work_outlined,
                  ),

                  const SizedBox(height: 15),
                  _buildInputLabel('City'),
                  _buildTextField(
                    hint: 'Jakarta Selatan',
                    prefixIcon: Icons.location_city_outlined,
                  ),

                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputLabel('State/Province'),
                            _buildTextField(
                              hint: 'DKI Jakarta',
                              prefixIcon: Icons.map_outlined,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInputLabel('Zip Code'),
                            _buildTextField(
                              hint: '12190',
                              prefixIcon: Icons.local_post_office_outlined,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Delivery Method Title
                  Row(
                    children: [
                      const Icon(Icons.local_shipping_outlined, color: Colors.grey, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        'Delivery Method',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color(0xFF071221),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  _buildDeliveryOption(
                    title: 'Standard Delivery',
                    subtitle: 'Estimasi 3 - 5 Hari Kerja',
                    price: 'Rp 20.000',
                    isSelected: true,
                  ),
                  const SizedBox(height: 10),
                  _buildDeliveryOption(
                    title: 'Express Delivery',
                    subtitle: 'Estimasi 1 - 2 Hari Kerja',
                    price: 'Rp 50.000',
                    isSelected: false,
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPaymentScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue to Payment',
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

  Widget _buildDeliveryOption({
    required String title,
    required String subtitle,
    required String price,
    required bool isSelected,
  }) {
    const primaryGreen = Color(0xFF5BC33C);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? primaryGreen.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? primaryGreen : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: isSelected ? primaryGreen : Colors.grey,
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: const Color(0xFF071221),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            price,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: primaryGreen,
            ),
          ),
        ],
      ),
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

  Widget _buildTextField({
    required String hint, 
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        keyboardType: keyboardType,
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
}
