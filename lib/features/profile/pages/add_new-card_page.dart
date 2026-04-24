import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  _AddNewCardScreenState createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  // Controllers لاستلام البيانات
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _nameController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.tvDB,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Add New Card",
            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // --- الكارت المطور (Card Preview) ---
            _buildCardPreview(),

            const SizedBox(height: 30),

            // --- حقول الإدخال ---
            _buildInputField(
              label: "Card Holder Name",
              controller: _nameController,
              hint: "SAMA WESAM",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 20),

            _buildInputField(
              label: "Card Number",
              controller: _cardNumberController,
              hint: "XXXX XXXX XXXX XXXX",
              icon: Icons.credit_card,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(16),
              ],
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    label: "Expiry Date",
                    controller: _expiryController,
                    hint: "MM/YY",
                    icon: Icons.calendar_today_outlined,
                    keyboardType: TextInputType.datetime,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(5),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildInputField(
                    label: "CVV",
                    controller: _cvvController,
                    hint: "XXX",
                    icon: Icons.lock_outline,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // --- زرار الحفظ ---
            _buildSaveButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- تصميم الكارت البريميوم ---
  Widget _buildCardPreview() {
    return Container(
      height: 210,
      width: double.infinity,
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
          )
        ],
      ),
      child: Stack(
        children: [
          // أشكال هندسية شفافة في الخلفية لتعطي عمق
          Positioned(
            top: -20,
            right: -20,
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white.withOpacity(0.05),
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

                // رقم الكارت بفونت مخصص للأرقام
                Text(
                  _cardNumberController.text.isEmpty
                      ? "**** **** **** ****"
                      : _formatCardNumber(_cardNumberController.text),
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
                          Text(
                            _nameController.text.isEmpty ? "SAMA WESAM" : _nameController.text.toUpperCase(),
                            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("EXPIRES", style: TextStyle(color: Colors.white60, fontSize: 9, letterSpacing: 1)),
                        const SizedBox(height: 4),
                        Text(
                          _expiryController.text.isEmpty ? "MM/YY" : _expiryController.text,
                          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
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

  // ويدجت الشريحة الذهبية
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.lightTextSecondary, fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          onChanged: (v) => setState(() {}),
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.lb,
            prefixIcon: Icon(icon, color: AppColors.tvDB2, size: 20),
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white24, fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.borderColor.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.primary500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
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
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text("Save Card",
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );
  }

  // دالة بسيطة لتقسيم أرقام الكارت 4-4-4-4
  String _formatCardNumber(String input) {
    String res = "";
    for (int i = 0; i < input.length; i++) {
      if (i % 4 == 0 && i != 0) res += " ";
      res += input[i];
    }
    return res;
  }
}