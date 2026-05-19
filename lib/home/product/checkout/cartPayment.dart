import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:decommers/home/homePage.dart';
import 'package:decommers/components/toast_popup.dart';

class CartPaymentScreen extends StatefulWidget {
  const CartPaymentScreen({super.key});

  @override
  State<CartPaymentScreen> createState() => _CartPaymentScreenState();
}

class _CartPaymentScreenState extends State<CartPaymentScreen> {
  static const primaryGreen = Color(0xFF5BC33C);
  String _selectedPayment = 'Credit Card';

  void _handlePayment() {
    // Show Success Modal
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                const SizedBox(height: 20),
                // Replace with real asset if available, using Icon for now
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: primaryGreen,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Payment Successful!",
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF071221),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Your order has been placed successfully.\nYou can track your order in the Orders menu.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Back to Home',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'Payment',
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
                title: 'Secure Payment',
                message: 'Semua transaksi Anda dienkripsi secara aman.',
                type: ToastType.success,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper (Index 2 = Payment)
            _buildStepper(2),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Payment Method Title
                  Row(
                    children: [
                      const Icon(Icons.payment_outlined, color: Colors.grey, size: 24),
                      const SizedBox(width: 10),
                      Text(
                        'Payment Method',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color(0xFF071221),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Payment Options
                  _buildPaymentOption(
                    title: 'Credit Card',
                    subtitle: 'Visa, Mastercard, JCB',
                    icon: Icons.credit_card,
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentOption(
                    title: 'E-Wallet',
                    subtitle: 'GoPay, OVO, Dana, LinkAja',
                    icon: Icons.account_balance_wallet_outlined,
                  ),
                  const SizedBox(height: 10),
                  _buildPaymentOption(
                    title: 'Bank Transfer',
                    subtitle: 'BCA, Mandiri, BNI, BRI',
                    icon: Icons.account_balance_outlined,
                  ),

                  const SizedBox(height: 40),

                  // Order Summary
                  Text(
                    'Order Summary',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: const Color(0xFF071221),
                    ),
                  ),
                  const SizedBox(height: 15),
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
                      children: [
                        _buildSummaryRow('Subtotal (4 Items)', 'Rp 500.000'),
                        const SizedBox(height: 12),
                        _buildSummaryRow('Delivery Fee', 'Rp 20.000'),
                        const SizedBox(height: 12),
                        _buildSummaryRow('Discount', '-Rp 150.000', isDiscount: true),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Divider(color: Color(0xFFF1F1F1)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Payment',
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF071221),
                              ),
                            ),
                            Text(
                              'Rp 370.000',
                              style: GoogleFonts.outfit(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: primaryGreen,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                  
                  // Pay Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: _handlePayment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Pay Now',
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

  Widget _buildSummaryRow(String label, String value, {bool isDiscount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDiscount ? Colors.redAccent : const Color(0xFF071221),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    bool isSelected = _selectedPayment == title;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPayment = title;
        });
      },
      child: Container(
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
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: isSelected ? primaryGreen.withOpacity(0.1) : const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: isSelected ? primaryGreen : Colors.grey[600]),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
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
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? primaryGreen : Colors.grey[300],
            ),
          ],
        ),
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
}
