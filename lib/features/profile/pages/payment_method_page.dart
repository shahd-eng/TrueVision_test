import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import 'add_new-card_page.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final Color bgColor = AppColors.tvDB;
  final Color accentTeal = AppColors.primary500;
  final Color cardColor = AppColors.lb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Payment Method",
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your Saved Cards",
              style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),

            // --- الكارت المطور (Premium Look) ---
            _buildCreditCard(),

            const SizedBox(height: 35),
            const Text(
              "Other Payment Methods",
              style: TextStyle(color: AppColors.lightTextSecondary, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),

            // --- قائمة وسائل الدفع ---
            _buildPaymentOption(Icons.credit_card, "Credit or Debit Card", "Mastercard **** 4422"),
            _buildPaymentOption(Icons.account_balance_wallet, "PayPal", "sama.wesam@email.com"),
            _buildPaymentOption(Icons.apple, "Apple Pay", "Connected"),

            const SizedBox(height: 40),

            // --- زرار إضافة كارت جديد ---
            _buildAddCardButton(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // الـ Widget المحدثة للكارت لتطابق ستايل صفحة الإضافة
  Widget _buildCreditCard() {
    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.tvDB2, AppColors.primary500],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary500.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // الخلفية الجمالية (Patterns)
          Positioned(
            top: -20,
            right: -20,
            child: CircleAvatar(
              radius: 65,
              backgroundColor: Colors.white.withOpacity(0.06),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -10,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.black.withOpacity(0.03),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildGoldChip(), // الشريحة الذهبية
                    const Icon(Icons.wifi_tethering, color: Colors.white54, size: 24),
                  ],
                ),
                const Spacer(),

                // رقم الكارت بفونت مونو
                Text(
                  "**** **** **** 4422",
                  style: GoogleFonts.shareTechMono(
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("CARD HOLDER", style: TextStyle(color: Colors.white60, fontSize: 9, letterSpacing: 1)),
                          const SizedBox(height: 4),
                          const Text(
                            "SAMA WESAM",
                            style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("EXPIRES", style: TextStyle(color: Colors.white60, fontSize: 9, letterSpacing: 1)),
                        const SizedBox(height: 4),
                        const Text("12/26", style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(width: 15),
                    const Icon(Icons.credit_card, color: Colors.white70, size: 30),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت الشريحة الذهبية (نفس اللي في صفحة الإضافة)
  Widget _buildGoldChip() {
    return Container(
      width: 45,
      height: 35,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF7D170), Color(0xFFBD931D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 2)],
      ),
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 30, height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 0.5),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: AppColors.tvDB,
          radius: 25,
          child: Icon(icon, color: accentTeal),
        ),
        title: Text(
          title,
          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.lightTextSecondary, fontSize: 12),
        ),
        trailing: const Icon(
          Icons.check_circle,
          color: AppColors.primaryButtonLight,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildAddCardButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [AppColors.tvDB2, AppColors.primary500]),
          boxShadow: [
            BoxShadow(color: AppColors.primary500.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5))
          ]
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewCardScreen()));
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add New Card",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}