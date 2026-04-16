import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  // Color Palette accurately sampled from your images
  static const Color scaffoldBg = Color(0xFF0F172A);
  static const Color cardBg = Color(0xFF1E293B);
  static const Color tealPrimary = Color(0xFF3D9889);
  static const Color textSecondary = Colors.white;
  static const Color inputBg = Color(0xFF101B2F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit Profile',
          style: GoogleFonts.workSans(
            // Updated to Inter to match Save button
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: GoogleFonts.inter(
                color: tealPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      // Fix: Use bottomNavigationBar to keep buttons at the bottom regardless of scroll
      bottomNavigationBar: _buildBottomActionButtons(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildProfileImagePicker(),
            const SizedBox(height: 32),

            _buildSectionHeader('Personal Information'),
            const SizedBox(height: 16),
            _buildTextField('Full Name', 'Ahmed Magdy'),
            const SizedBox(height: 16),
            _buildTextField('Email Address', 'Example@email.com'),
            const SizedBox(height: 16),
            _buildTextField('Phone Number', '+20 123 456 7890', subLabel: ' (Optional)'),
            const SizedBox(height: 16),
            _buildTextField('Username', '@ahmed_t1'),

            const SizedBox(height: 32),
            _buildSectionHeader('Account Status'),
            const SizedBox(height: 16),
            _buildVerifiedCard(),

            const SizedBox(height: 32),
            _buildSectionHeader('Security', hasDividers: true),
            const SizedBox(height: 16),
            _buildSecurityTile(
              imagePath: 'assets/images/Vector (8).png',
              title: 'Change Password',
              subtitle: 'Update your password',
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 12),
            _buildSecurityTile(
              imagePath: 'assets/images/Vector (9).png',
              title: 'Two-Factor Authentication',
              subtitle: 'Enabled',
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStatusBadge('Active'),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24), // Bottom padding for scroll
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImagePicker() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.person, size: 88, color: Colors.grey),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: tealPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ), // Match bg color
                ),
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Change Profile Photo',
          style: GoogleFonts.inter(
            color: tealPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, {bool hasDividers = false}) {
    if (!hasDividers) {
      return Center(
        child: Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      );
    }

    return Row(
      children: [
        Expanded(child: Divider(color: const Color(0xFF3D9889).withOpacity(0.3), thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            style: GoogleFonts.inter(
              color: textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Expanded(child: Divider(color: const Color(0xFF3D9889).withOpacity(0.3), thickness: 1)),
      ],
    );
  }

  Widget _buildTextField(String label, String value, {String? subLabel}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: tealPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (subLabel != null)
              Text(
                subLabel,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        AppTextField(
          initialValue: value,
        ),
      ],
    );
  }

  Widget _buildVerifiedCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verified Account',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF111827),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Your account is verified',
                  style: GoogleFonts.inter(
                    color: Color(0xFF4B5563),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.help_outline_rounded,
            color: Color(0xFF22C55E),
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityTile({
    required String imagePath, // Changed from IconData icon to String imagePath
    required String title,
    required String subtitle,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF101B2F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF3D9889).withOpacity(0.5), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [tealPrimary.withOpacity(0.8), scaffoldBg],
              ),
            ),
            child: Image.asset(
              imagePath, // Now uses the dynamic path passed to the function
              width: 14,
              height: 16,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(color: textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          color: const Color(0xFF16A34A),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }



  Widget _buildBottomActionButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: const BoxDecoration(
        color: scaffoldBg,
        border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF8FAFC),
                  foregroundColor: const Color(0xFF334155),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              text: 'Save Changes',
              height: 54,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}