// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../dashboard/widgets/dashboard_bottom_nav_bar.dart';
//
// // Assuming these are your paths, adjust if different
// // import '../../../core/utils/app_colors.dart';
// // import '../../../widgets/dashboard_bottom_nav_bar.dart';
//
// class SubscriptionPlansScreen extends StatefulWidget {
//   const SubscriptionPlansScreen({super.key});
//
//   @override
//   State<SubscriptionPlansScreen> createState() => _SubscriptionPlansScreenState();
// }
//
// class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
//   bool isYearly = true;
//   // Initialize to 4 if you want "Profile" selected by default based on your nav bar indices
//   int _selectedIndex = 4;
//
//   // Theme Colors
//   static const Color scaffoldBg = Color(0xFF0F172A);
//   static const Color cardBg = Color(0xFF1E293B);
//   static const Color tealPrimary = Color(0xFF3D9889);
//   static const Color textSecondary = Color(0xFFFFFFFF);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: scaffoldBg,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Subscription Plans',
//           style: GoogleFonts.workSans(
//             color: Colors.white,
//             fontWeight: FontWeight.w700,
//             fontSize: 20,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.info, color: Colors.white, size: 20,),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       // UPDATED: Integration of custom DashboardBottomNavBar
//       bottomNavigationBar: DashboardBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onTabSelected: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//           // Add navigation logic here if needed
//         },
//         onScanTap: () {
//           // Add Scan functionality here
//         },
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           children: [
//             const SizedBox(height: 10),
//             _buildCurrentPlanCard(),
//             const SizedBox(height: 24),
//             _buildBillingToggle(),
//             const SizedBox(height: 24),
//             _buildPlanCard(
//               title: 'Free',
//               price: '0',
//               description: 'Perfect for trying out our service',
//               features: [
//                 '5 analyses per month',
//                 'Basic detection reports',
//                 'Standard processing',
//               ],
//               buttonText: 'Current Plan',
//               isCurrent: true,
//               iconPath: 'Assets/images/shield.png'
//
//             ),
//             const SizedBox(height: 16),
//             _buildPlanCard(
//               title: 'Premium',
//               price: '19',
//               description: 'Best for regular users and content creators',
//               features: [
//                 '100 analyses per month',
//                 'Detailed detection reports',
//                 'Priority processing',
//                 'Email support',
//               ],
//               buttonText: 'Upgrade to Premium',
//               isPopular: true,
//               iconPath: 'Assets/images/star.png',
//
//             ),
//             const SizedBox(height: 16),
//             _buildPlanCard(
//               title: 'Pro',
//               price: '49',
//               description: 'For professionals and businesses',
//               features: [
//                 'Unlimited analyses',
//                 'Advanced detection reports',
//                 'Instant processing',
//                 'Educational modules',
//                 '24/7 priority support',
//               ],
//               buttonText: 'Select Pro',
//               iconPath: 'Assets/images/i (1).png',
//               iconColor: Colors.orangeAccent,
//             ),
//             const SizedBox(height: 32),
//             _buildPaymentSection(),
//             const SizedBox(height: 40),
//             _buildFooterLinks(),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCurrentPlanCard() {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF3D9889), Color(0xFF0E1728)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: tealPrimary, width: 1),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: tealPrimary,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: const Text('Your Current Plan', style: TextStyle(color: Colors.white, fontSize: 14)),
//               ),
//               const Text('Active', style: TextStyle(color: textSecondary, fontSize: 14)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           const Text('Free Plan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//           const SizedBox(height: 4,),
//           const Text('Next renewal: Never', style: TextStyle(color: textSecondary, fontSize: 14)),
//           const SizedBox(height: 12),
//           const Row(
//             children: [
//               Icon(Icons.check, color: Color(0xFF22C55E), size: 18),
//               SizedBox(width: 8),
//               Text('5 monthly analyses remaining', style: TextStyle(color: textSecondary, fontSize: 14)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBillingToggle() {
//     return Container(
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: const Color(0xFF101B2F),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _toggleItem('Monthly', !isYearly),
//           _toggleItem('Yearly', isYearly),
//           const SizedBox(width: 8),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(
//               color: const Color(0xFFDCFCE7),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: const Text('Save 20%', style: TextStyle(color: Color(0xFF16A34A), fontSize: 12, fontWeight: FontWeight.bold)),
//           ),
//           const SizedBox(width: 8),
//         ],
//       ),
//     );
//   }
//
//   Widget _toggleItem(String title, bool active) {
//     return GestureDetector(
//       onTap: () => setState(() => isYearly = title == 'Yearly'),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//         decoration: BoxDecoration(
//           color: active ? tealPrimary : Colors.transparent,
//           borderRadius: BorderRadius.circular(30),
//         ),
//         child: Text(title, style: TextStyle(color: active ? Colors.white : textSecondary, fontWeight: FontWeight.w600)),
//       ),
//     );
//   }
//
//   Widget _buildPlanCard({
//     required String title,
//     required String price,
//     required String description,
//     required List<String> features,
//     required String buttonText,
//     bool isCurrent = false,
//     bool isPopular = false,
//     required String iconPath, // Changed from IconData icon
//     Color iconColor = tealPrimary,
//   }) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: scaffoldBg,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: tealPrimary),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(title, style: const TextStyle(color: tealPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
//                   // Replaced Icon with Image.asset
//                   Image.asset(
//                     iconPath,
//                     width: 24, // Adjust size as needed
//                     height: 24,
//                     fit: BoxFit.contain,
//                     // Use color only if you want to tint a monochrome PNG/Vector
//                     // color: textSecondary,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.baseline,
//                 textBaseline: TextBaseline.alphabetic,
//                 children: [
//                   Text('\$$price', style: const TextStyle(color: tealPrimary, fontSize: 32, fontWeight: FontWeight.bold)),
//                   const Text(' /month', style: TextStyle(color: textSecondary, fontSize: 14)),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Text(description, style: const TextStyle(color: textSecondary, fontSize: 14)),
//               const SizedBox(height: 16),
//               ...features.map((f) => Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.check, color: Color(0xFF22C55E), size: 18),
//                     const SizedBox(width: 12),
//                     Text(f, style: const TextStyle(color: Colors.white, fontSize: 14)),
//                   ],
//                 ),
//               )).toList(),
//               const SizedBox(height: 16),
//               _buildPlanButton(buttonText, isCurrent),
//             ],
//           ),
//         ),
//         if (isPopular)
//           Positioned(
//             top: -12,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//                 decoration: BoxDecoration(color: tealPrimary, borderRadius: BorderRadius.circular(20)),
//                 child: const Text('Most Popular', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
//
//   Widget _buildPlanButton(String text, bool isCurrent) {
//     return Container(
//       width: double.infinity,
//       height: 54,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         gradient: isCurrent ? null : const LinearGradient(colors: [Color(0xFF3EB372), Color(0xFF237374)]),
//         border: isCurrent ? Border.all(color: tealPrimary, width: 0.5) : null,
//       ),
//       child: Center(
//         child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
//       ),
//     );
//   }
//
//   Widget _buildPaymentSection() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Payment & Billing', style: TextStyle(color: tealPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
//         const SizedBox(height: 12),
//         Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: inputBg,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: tealPrimary),
//           ),
//           child: Row(
//             children: [
//               Image.asset('Assets/images/Vector (10).png', width: 32, height: 24),
//               const SizedBox(width: 12),
//               const Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('•••• 4242', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
//                     Text('Expires 12/25', style: TextStyle(color: textSecondary, fontSize: 12)),
//                   ],
//                 ),
//               ),
//               const Text('Change', style: TextStyle(color: tealPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         _buildCompareButton(),
//       ],
//     );
//   }
//
//   Widget _buildCompareButton() {
//     return Container(
//       width: double.infinity,
//       height: 54,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         gradient: const LinearGradient(colors: [Color(0xFF3EB372), Color(0xFF237374)]),
//       ),
//       child: const Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.list_alt, color: Colors.white),
//           SizedBox(width: 8),
//           Text('Compare Plans', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFooterLinks() {
//     return Column(
//       children: [
//         const Text('Cancel anytime. No hidden fees.', style: TextStyle(color: textSecondary, fontSize: 12)),
//         const SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Terms of Service', style: TextStyle(color: tealPrimary, fontSize: 12)),
//             const SizedBox(width: 16),
//             Text('Privacy Policy', style: TextStyle(color: tealPrimary, fontSize: 12)),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// const Color inputBg = Color(0xFF101B2F);
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/app_button.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() => _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  bool isYearly = true;

  static const Color scaffoldBg = Color(0xFF0F172A);
  static const Color tealPrimary = Color(0xFF3D9889);
  static const Color textSecondary = Colors.white;

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
          'Subscription Plans',
          style: GoogleFonts.workSans(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info, color: Colors.white, size: 20,),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildCurrentPlanCard(),
            const SizedBox(height: 24),
            _buildBillingToggle(),

            // --- DIVIDER ADDED HERE ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Divider(
                color: tealPrimary,
                thickness: 1,
              ),
            ),

            _buildPlanCard(
                title: 'Free',
                price: '0',
                description: 'Perfect for trying out our service',
                features: [
                  '5 analyses per month',
                  'Basic detection reports',
                  'Standard processing',
                ],
                buttonText: 'Current Plan',
                isCurrent: true,
                iconPath: 'assets/images/shield.png'
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              title: 'Premium',
              price: '19',
              description: 'Best for regular users and content creators',
              features: [
                '100 analyses per month',
                'Detailed detection reports',
                'Priority processing',
                'Email support',
              ],
              buttonText: 'Upgrade to Premium',
              isPopular: true,
              isPrimary: true,
              iconPath: 'assets/images/star.png',
            ),
            const SizedBox(height: 16),
            _buildPlanCard(
              title: 'Pro',
              price: '49',
              description: 'For professionals and businesses',
              features: [
                'Unlimited analyses',
                'Advanced detection reports',
                'Instant processing',
                'Educational modules',
                '24/7 priority support',
              ],
              buttonText: 'Select Pro',
              iconPath: 'assets/images/i (1).png',
              iconColor: Colors.orangeAccent,
            ),

            // --- DIVIDER ADDED BEFORE PAYMENT ---
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: Divider(
                color: tealPrimary,
                thickness: 1,
              ),
            ),

            _buildPaymentSection(),
            const SizedBox(height: 40),
            _buildFooterLinks(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ... (All other _build methods remain exactly as you have them)

  Widget _buildCurrentPlanCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF3D9889), Color(0xFF0E1728)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tealPrimary, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: tealPrimary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Your Current Plan', style: TextStyle(color: Colors.white, fontSize: 14)),
              ),
              const Text('Active', style: TextStyle(color: textSecondary, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Free Plan', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4,),
          const Text('Next renewal: Never', style: TextStyle(color: textSecondary, fontSize: 14)),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.check, color: Color(0xFF22C55E), size: 18),
              SizedBox(width: 8),
              Text('5 monthly analyses remaining', style: TextStyle(color: textSecondary, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF101B2F),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _toggleItem('Monthly', !isYearly),
          _toggleItem('Yearly', isYearly),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Save 20%', style: TextStyle(color: Color(0xFF16A34A), fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _toggleItem(String title, bool active) {
    return GestureDetector(
      onTap: () => setState(() => isYearly = title == 'Yearly'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: active ? tealPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(title, style: TextStyle(color: active ? Colors.white : textSecondary, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String price,
    required String description,
    required List<String> features,
    required String buttonText,
    bool isCurrent = false,
    bool isPopular = false,
    bool isPrimary = false,
    required String iconPath,
    Color iconColor = tealPrimary,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: scaffoldBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tealPrimary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: const TextStyle(color: tealPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
                  Image.asset(
                    iconPath,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text('\$$price', style: const TextStyle(color: tealPrimary, fontSize: 32, fontWeight: FontWeight.bold)),
                  const Text(' /month', style: TextStyle(color: textSecondary, fontSize: 14)),
                ],
              ),
              const SizedBox(height: 12),
              Text(description, style: const TextStyle(color: textSecondary, fontSize: 14)),
              const SizedBox(height: 16),
              ...features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check, color: Color(0xFF22C55E), size: 18),
                    const SizedBox(width: 12),
                    Text(f, style: const TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),
              )).toList(),
              const SizedBox(height: 16),
              isPrimary
                  ? AppButton(text: buttonText, onPressed: () {}, height: 54)
                  : _buildPlanButton(buttonText, isCurrent),
            ],
          ),
        ),
        if (isPopular)
          Positioned(
            top: -12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(color: tealPrimary, borderRadius: BorderRadius.circular(20)),
                child: const Text('Most Popular', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlanButton(String text, bool isCurrent) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: isCurrent ? null : const LinearGradient(colors: [Color(0xFF3EB372), Color(0xFF237374)]),
        border: isCurrent ? Border.all(color: tealPrimary, width: 0.5) : null,
      ),
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Payment & Billing', style: TextStyle(color: tealPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: inputBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: tealPrimary),
          ),
          child: Row(
            children: [
              Image.asset('assets/images/Vector (10).png', width: 32, height: 24),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('•••• 4140', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
              const Text('Change', style: TextStyle(color: tealPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _buildCompareButton(),
      ],
    );
  }

  Widget _buildCompareButton() {
    return AppButton(
      text: 'Compare Plans',
      height: 54,
      icon: const Icon(Icons.list_alt, color: Colors.white),
      onPressed: () {},
    );
  }

  Widget _buildFooterLinks() {
    return Column(
      children: [
        const Text('Cancel anytime. No hidden fees.', style: TextStyle(color: textSecondary, fontSize: 12)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Terms of Service', style: TextStyle(color: tealPrimary, fontSize: 12)),
            const SizedBox(width: 16),
            Text('Privacy Policy', style: TextStyle(color: tealPrimary, fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

const Color inputBg = Color(0xFF101B2F);