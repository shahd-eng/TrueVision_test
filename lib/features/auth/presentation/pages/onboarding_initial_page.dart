// import 'package:flutter/material.dart';
// import 'package:true_vision/core/constants/app_images.dart';
// import 'package:true_vision/core/theme/app_colors.dart';
// import 'package:true_vision/core/widgets/primary_button.dart';
// import 'package:true_vision/features/auth/presentation/pages/onboarding_page.dart';
//
// class OnboardingInitialPage extends StatefulWidget {
//   const OnboardingInitialPage({super.key});
//
//   static const String routeName = '/onboarding-initial';
//
//   @override
//   State<OnboardingInitialPage> createState() => _OnboardingInitialPageState();
// }
//
// class _OnboardingInitialPageState extends State<OnboardingInitialPage> {
//   final PageController _pageController = PageController();
//   int _currentPageIndex = 0;
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }
//
//   void _handleSkip() {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute<void>(
//         builder: (_) => const OnboardingPage(),
//       ),
//     );
//   }
//
//   void _handleNext() {
//     if (_currentPageIndex < 2) {
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     } else {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute<void>(
//           builder: (_) => const OnboardingPage(),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: CustomPaint(
//               painter: _OnboardingTopBackgroundPainter(),
//             ),
//           ),
//           SafeArea(
//             child: Column(
//               children: [
//                 _SkipButton(onPressed: _handleSkip),
//                 Expanded(
//                   child: PageView.builder(
//                     controller: _pageController,
//                     onPageChanged: (index) {
//                       setState(() {
//                         _currentPageIndex = index;
//                       });
//                     },
//                     itemCount: 3,
//                     itemBuilder: (context, index) {
//                       return const _OnboardingInitialContent();
//                     },
//                   ),
//                 ),
//                 _OnboardingInitialTextContent(),
//                 const SizedBox(height: 30),
//                 _OnboardingDotsIndicator(activeIndex: _currentPageIndex),
//                 const SizedBox(height: 40),
//                 PrimaryButton(
//                   label: 'Next',
//                   onPressed: _handleNext,
//                 ),
//                 const SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SkipButton extends StatelessWidget {
//   const _SkipButton({required this.onPressed});
//
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Padding(
//         padding: const EdgeInsets.only(right: 16),
//         child: TextButton(
//           onPressed: onPressed,
//           child: const Text(
//             'Skip',
//             style: TextStyle(color: Colors.white70),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _OnboardingInitialContent extends StatelessWidget {
//   const _OnboardingInitialContent();
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 120),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.35,
//           child: Image.asset(
//             AppImages.onboardingSecurity,
//             fit: BoxFit.contain,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _OnboardingInitialTextContent extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Detect beyond your media',
//           style: TextStyle(
//             color: AppColors.textSecondary,
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           'Detecting manipulated audio,\nimages, and videos',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             color: AppColors.lightTextSecondary,
//             fontSize: 14,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _OnboardingDotsIndicator extends StatelessWidget {
//   const _OnboardingDotsIndicator({required this.activeIndex});
//
//   final int activeIndex;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(
//         3,
//         (index) => Container(
//           margin: const EdgeInsets.symmetric(horizontal: 4),
//           height: 8,
//           width: index == activeIndex ? 24 : 8,
//           decoration: BoxDecoration(
//             color: index == activeIndex
//                 ? AppColors.primaryBackgroundLightColor
//                 : Colors.grey.shade300,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _OnboardingTopBackgroundPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final double width = size.width;
//     final double height = size.height;
//
//     final Rect rect = Rect.fromLTWH(0, 0, width, height);
//     const Gradient gradient = LinearGradient(
//       colors: [
//         AppColors.tvDB,
//         AppColors.primaryBackgroundLightColor,
//       ],
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//     );
//
//     final Paint paint = Paint()
//       ..shader = gradient.createShader(rect)
//       ..style = PaintingStyle.fill;
//
//     final Path path = Path();
//     path.lineTo(0, height * 0.55);
//     path.quadraticBezierTo(width * 0.1, height * 0.45, width * 0.5, height * 0.5);
//     path.quadraticBezierTo(width * 0.9, height * 0.55, width, height * 0.4);
//     path.lineTo(width, 0);
//     path.close();
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
//
