// // import 'package:flutter/material.dart';
// // import 'package:true_vision/core/constants/app_images.dart';
// // import 'package:true_vision/core/widgets/primary_button.dart';
// // import '../../../../core/theme/app_colors.dart';
// //
// // class OnboardingPage extends StatefulWidget {
// //   const OnboardingPage({super.key});
// //   @override
// //   State<OnboardingPage> createState() => _OnboardingPageState();
// // }
// //
// // class _OnboardingPageState extends State<OnboardingPage> {
// //   final PageController _controller = PageController();
// //   int _currentPage = 0;
// //
// //   // البيانات الخاصة بكل صفحة
// //   final List<Map<String, String>> _onboardingData = [
// //     {
// //       "title": "Detect beyond your med",
// //       "sub": "Detecting manipulated audio,\nimages, and videos",
// //       "image": AppImages.onboardingSecurity, // تأكدي من مسمى الصورة في ملفك
// //     },
// //     {
// //       "title": "Protect your media\nKeep it authentic",
// //       "sub": "Ensuring your media stays original\nand protected",
// //       "image": AppImages.onboardingTeam,
// //     },
// //     {
// //       "title": "View Deepfake Trends",
// //       "sub": "Tracking the latest deepfake patterns and activities\n\"Trust What You See, Verify What You Hear\"",
// //       "image": AppImages.onboardingAnalysis,
// //     },
// //   ];
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFFF5F5F5),body: Stack(
// //       children: [
// //
// //         Positioned(
// //           top: _currentPage % 2 == 0 ? 0 : null,
// //           bottom: _currentPage % 2 == 0 ? null : 0,
// //           left: 0,
// //           right: 0,
// //
// //           height: MediaQuery.of(context).size.height * 0.5,
// //           child: CustomPaint(
// //
// //             painter: _currentPage % 2 == 0
// //                 ? HeaderWavePainter()
// //                 : BottomHeaderWavePainter(),
// //           ),
// //         ),
// //
// //
// //         SafeArea(
// //           child: Column(
// //             children: [
// //               // زر Skip
// //               Align(
// //                 alignment: Alignment.centerRight,
// //                 child: Padding(
// //                   padding: const EdgeInsets.only(right: 16),
// //                   child: TextButton(
// //                     onPressed: () {
// //
// //                       _controller.animateToPage(2,
// //                           duration: const Duration(milliseconds: 400),
// //                           curve: Curves.easeInOut);
// //                     },
// //                     child: Text('Skip',
// //                         style: TextStyle(
// //
// //                           color: _currentPage % 2 == 0 ? Colors.white70 : const Color(0xFF0E1728),
// //                         )),
// //                   ),
// //                 ),
// //               ),
// //
// //
// //               Expanded(
// //                 child: PageView.builder(
// //                   controller: _controller,
// //                   onPageChanged: (v) => setState(() => _currentPage = v),
// //                   itemCount: _onboardingData.length,
// //                   itemBuilder: (context, index) {
// //                     return OnboardingContent(
// //                       data: _onboardingData[index],
// //
// //                       isCurveTop: index % 2 == 0,
// //                     );
// //                   },
// //                 ),
// //               ),
// //
// //
// //               _DotsIndicator(activeIndex: _currentPage),
// //               const SizedBox(height: 16),
// //
// //               Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 16),
// //                 child: PrimaryButton(
// //                   label: _currentPage == _onboardingData.length - 1 ? "Get started" : "Next",
// //                   onPressed: () {
// //                     if (_currentPage < _onboardingData.length - 1) {
// //                       _controller.nextPage(
// //                         duration: const Duration(milliseconds: 300),
// //                         curve: Curves.easeIn,
// //                       );
// //                     } else {
// //                       // هنا هتروح لصفحة الـ Login
// //                     }
// //                   },
// //                 ),
// //               ),
// //
// //               SizedBox(height: 90,),
// //
// //             ],
// //           ),
// //         ),
// //       ],
// //     ),
// //     );
// //   }
// // }
// //
// //
// // class BottomHeaderWavePainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final w = size.width;
// //     final h = size.height;
// //
// //     final paint = Paint()
// //       ..shader = const LinearGradient(
// //         colors: [
// //           Color(0xFF0E1728),
// //           Color(0xFF277A68),
// //
// //         ],
// //         begin: Alignment.bottomCenter,
// //         end: Alignment.topCenter,
// //       ).createShader(Rect.fromLTWH(0, 0, w, h))
// //       ..style = PaintingStyle.fill;
// //
// //     Path path = Path();
// //
// //
// //     double startHeight = h * 0.3;
// //     path.moveTo(w, h);
// //     path.lineTo(w, startHeight);
// //
// //     path.quadraticBezierTo(
// //       w * 0.95, h * 0.1,
// //       w * 0.80, h * 0.1,
// //     );
// //
// //
// //     path.lineTo(w * 0.20, h * 0.1);
// //
// //
// //     path.quadraticBezierTo(
// //       w * 0.05, h * 0.1,
// //       0, h * 0.0,
// //     );
// //
// //
// //     path.lineTo(0, h);
// //     path.close();
// //
// //     canvas.drawPath(path, paint);
// //   }
// //
// //   @override
// //   bool shouldRepaint(CustomPainter oldDelegate) => false;
// // }
// //
// //
// // class OnboardingContent extends StatelessWidget {
// //   final Map<String, String> data;
// //   final bool isCurveTop;
// //
// //   const OnboardingContent({super.key, required this.data, required this.isCurveTop});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 20),
// //       child: Column(
// //         children: [
// //           const SizedBox(height: 40),
// //           Text(
// //             data["title"]!,
// //             textAlign: TextAlign.center,
// //             style: const TextStyle(
// //               fontSize: 24,
// //               fontWeight: FontWeight.bold,
// //               color: Color(0xFF0E1728),
// //               height: 1.2,
// //             ),
// //           ),
// //           const SizedBox(height: 12),
// //           Text(
// //             data["sub"]!,
// //             textAlign: TextAlign.center,
// //             style: const TextStyle(
// //               fontSize: 14,
// //               color: Color(0xFF7A8CA3),
// //               height: 1.5,
// //             ),
// //           ),
// //
// //
// //           Expanded(
// //             child: Container(
// //               alignment: Alignment.center,
// //
// //               child: Transform.translate(
// //                 offset: const Offset(0, 10),
// //                 child: Image.asset(
// //                   data["image"]!,
// //                   fit: BoxFit.contain,
// //                   width: MediaQuery.of(context).size.width * 0.85,
// //                 ),
// //               ),
// //             ),
// //           ),
// //
// //           const SizedBox(height: 20),
// //         ],
// //       ),
// //     );
// //   }
// // }
// //
// //
// // class _DotsIndicator extends StatelessWidget {
// //   final int activeIndex;
// //   const _DotsIndicator({required this.activeIndex});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: List.generate(3, (index) => Container(
// //         margin: const EdgeInsets.symmetric(horizontal: 4),
// //         height: 8,
// //         width: index == activeIndex ? 8 : 8,
// //         decoration: BoxDecoration(
// //           color: index == activeIndex ? AppColors.primaryBackgroundLightColor : Colors.grey.shade300,
// //           borderRadius: BorderRadius.circular(4),
// //         ),
// //       )),
// //     );
// //   }
// // }
// // //------------------------------------
// //
// //
// //
// //
// // class OnboardingStepTwo extends StatelessWidget {
// //   const OnboardingStepTwo({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final double screenHeight = MediaQuery.of(context).size.height;
// //
// //     return Scaffold(
// //       backgroundColor: Colors.white, // الجزء السفلي أبيض صريح
// //       body: Stack(
// //         children: [
// //
// //           Positioned(
// //             top: 0,
// //             left: 0,
// //             right: 0,
// //             height: screenHeight * 0.55,
// //             child: CustomPaint(
// //               painter: HeaderWavePainter(),
// //             ),
// //           ),
// //
// //
// //           SafeArea(
// //             child: Column(
// //               children: [
// //
// //                 Align(
// //                   alignment: Alignment.centerRight,
// //                   child: Padding(
// //                     padding: const EdgeInsets.only(right: 20, top: 10),
// //                     child: TextButton(
// //                       onPressed: () {},
// //                       child: const Text(
// //                         'Skip',
// //                         style: TextStyle(color: Colors.white70, fontSize: 16),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //
// //
// //
// //                 Transform.translate(
// //                   offset: const Offset(0, -20),
// //                   child: Image.asset(
// //                     AppImages.onboardingSecurity,
// //                     width: 370,
// //                     height: 390,
// //                     fit: BoxFit.contain,
// //                   ),
// //                 ),
// //
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 20),
// //                   child: Column(
// //                     children: [
// //                       const Text(
// //                         "Detect beyond your media",
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           fontSize: 18,
// //                           fontWeight: FontWeight.bold,
// //                           color: Color(0xFF0E1728),
// //                         ),
// //                       ),
// //                       const SizedBox(height: 12),
// //                       const Text(
// //                         "Detecting manipulated audio,\nimages, and videos",
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                           fontSize: 14,
// //                           color: Color(0xFF7A8CA3),
// //                           height: 1.5,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 40),
// //
// //                       // Indicators (نقط التنقل)
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           _dot(isActive: false),
// //                           _dot(isActive: true),
// //                           _dot(isActive: false),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 16),
// //
// //                       PrimaryButton(label: "Next", onPressed: () {}),
// //
// //                       const SizedBox(height: 15),
// //
// //
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(height: 20),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //
// //   Widget _dot({required bool isActive}) {
// //     return Container(
// //       margin: const EdgeInsets.symmetric(horizontal: 4),
// //       height: 10,
// //       width: 10,
// //       decoration: BoxDecoration(
// //         color: isActive ? const Color(0xFF277A68) : Colors.grey.shade300,
// //         shape: BoxShape.circle,
// //       ),
// //     );
// //   }
// //
// //
// //   Widget _buildGradientButton() {
// //     return Container(
// //       width: double.infinity,
// //       height: 56,
// //       decoration: BoxDecoration(
// //         gradient: const LinearGradient(
// //           colors: [Color(0xFF277A68), Color(0xFF1B5347)],
// //           begin: Alignment.centerLeft,
// //           end: Alignment.centerRight,
// //         ),
// //         borderRadius: BorderRadius.circular(15),
// //       ),
// //       child: ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Colors.transparent,
// //           shadowColor: Colors.transparent,
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
// //         ),
// //         onPressed: () {},
// //         child: const Text(
// //           "Nex",
// //           style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
// //         ),
// //       ),
// //     );
// //   }
// // }
// //
// //
// // class HeaderWavePainter extends CustomPainter {
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final w = size.width;
// //     final h = size.height; // تأكدي إن الـ Container اللي شايله واخد نصف ارتفاع الشاشة
// //
// //     final paint = Paint()
// //       ..shader = const LinearGradient(
// //         colors: [
// //           Color(0xFF277A68), // اللون الأخضر الفاتح
// //           Color(0xFF0E1728), // اللون الكحلي الغامق
// //         ],
// //         begin: Alignment.topCenter,
// //         end: Alignment.bottomCenter,
// //       ).createShader(Rect.fromLTWH(0, 0, w, h))
// //       ..style = PaintingStyle.fill;
// //
// //     Path path = Path();
// //
// //     // 1. البداية من اليسار (عند منتصف ارتفاع الـ Painter)
// //     double startHeight = h * 0.7;
// //     path.lineTo(0, startHeight);
// //
// //     // 2. الجزء الأول (المنحنى الأيسر): واخد 20% من العرض
// //     path.quadraticBezierTo(
// //       w * 0.05, h * 0.9, // نقطة التحكم (Control Point)
// //       w * 0.20, h * 0.9, // نهاية المنحنى (بدء الاستقامة)
// //     );
// //
// //     // 3. الجزء الثاني (الخط المستقيم): واخد 60% من العرض وموجود في النص بالظبط
// //     // من 20% لـ 80% عشان يكون متوسط الشاشة
// //     path.lineTo(w * 0.80, h * 0.9);
// //
// //     // 4. الجزء الثالث (المنحنى الأيمن): واخد 20% من العرض (تماثل تام مع الأول)
// //     path.quadraticBezierTo(
// //       w * 0.95, h * 0.9, // نفس ميل المنحنى الأول باختلاف الاتجاه
// //       w, h * 1.0,        // نهاية المسار
// //     );
// //
// //     // 5. قفل المسار من الأعلى
// //     path.lineTo(w, 0);
// //     path.close();
// //
// //     canvas.drawPath(path, paint);
// //   }
// //
// //   @override
// //   bool shouldRepaint(CustomPainter oldDelegate) => false;
// // }
// //------------------------------------------------------------------------------------
// import 'package:flutter/material.dart';
// import 'package:true_vision/core/constants/app_images.dart';
// import 'package:true_vision/core/widgets/primary_button.dart';
// import '../../../../core/theme/app_colors.dart';
//
// class OnboardingPage extends StatefulWidget {
//   const OnboardingPage({super.key});
//
//   @override
//   State<OnboardingPage> createState() => _OnboardingPageState();
// }
//
// class _OnboardingPageState extends State<OnboardingPage> {
//   final PageController _controller = PageController();
//   int _currentPage = 0;
//
//   // البيانات المنظمة لكل صفحة
//   final List<Map<String, String>> _onboardingData = [
//     {
//       "title": "Detect beyond your media",
//       "sub": "Detecting manipulated audio,\nimages, and videos",
//       "image": AppImages.onboardingSecurity,
//     },
//     {
//       "title": "Protect your media\nKeep it authentic",
//       "sub": "Ensuring your media stays original\nand protected",
//       "image": AppImages.onboardingTeam,
//     },
//     {
//       "title": "View Deepfake Trends",
//       "sub": "Tracking the latest deepfake patterns and activities\n\"Trust What You See, Verify What You Hear\"",
//       "image": AppImages.onboardingAnalysis,
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     // تحديد مكان الكيرف: زوجي (0, 2) فوق، فردي (1) تحت
//     bool isCurveTop = _currentPage % 2 == 0;
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           // 1. الخلفية المتغيرة (الكيرف)
//           Positioned(
//             top: isCurveTop ? 0 : null,
//             bottom: isCurveTop ? null : 0,
//             left: 0,
//             right: 0,
//             height: MediaQuery.of(context).size.height * 0.5,
//             child: CustomPaint(
//               painter: isCurveTop ? HeaderWavePainter() : BottomHeaderWavePainter(),
//             ),
//           ),
//
//           // 2. المحتوى
//           SafeArea(
//             child: Column(
//               children: [
//                 // زر Skip العلوي بلون يتغير حسب الخلفية
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Padding(
//                     padding: const EdgeInsets.only(right: 16),
//                     child: TextButton(
//                       onPressed: () => _controller.animateToPage(
//                         2,
//                         duration: const Duration(milliseconds: 400),
//                         curve: Curves.easeInOut,
//                       ),
//                       child: const Text(
//                         'Skip',
//                         style: TextStyle(
//
//                             color:AppColors.shadowColor,
//                             fontSize: 10,
//                             fontWeight: FontWeight.w500
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 // محتوى الصفحات
//                 Expanded(
//                   child: PageView.builder(
//                     controller: _controller,
//                     onPageChanged: (v) => setState(() => _currentPage = v),
//                     itemCount: _onboardingData.length,
//                     itemBuilder: (context, index) {
//                       return OnboardingContent(
//                         data: _onboardingData[index],
//                         isCurveTop: index % 2 == 0,
//                       );
//                     },
//                   ),
//                 ),
//
//                 // مؤشرات الصفحات (Dots)
//                 _DotsIndicator(activeIndex: _currentPage),
//                 const SizedBox(height: 24),
//
//                 // زر التحكم السفلي
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: PrimaryButton(
//                     label: _currentPage == _onboardingData.length - 1 ? "Get started" : "Next",
//                     onPressed: () {
//                       if (_currentPage < _onboardingData.length - 1) {
//                         _controller.nextPage(
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.easeIn,
//                         );
//                       } else {
//                         // هنا ننتقل لصفحة Login
//                       }
//                     },
//                   ),
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
// // ويدجت عرض المحتوى الموحد
// class OnboardingContent extends StatelessWidget {
//   final Map<String, String> data;
//   final bool isCurveTop;
//
//   const OnboardingContent({super.key, required this.data, required this.isCurveTop});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (isCurveTop) ...[
//
//             Expanded(
//               flex: 3,
//               child: Transform.translate(
//                 offset: const Offset(0, -20),
//                 child: Image.asset(data["image"]!, fit: BoxFit.contain),
//               ),
//             ),
//             const SizedBox(height: 20),
//             _buildTextContent(),
//             const Spacer(flex: 1),
//           ] else ...[
//             // الحالة: كيرف تحت -> نص فوق (في الأبيض) ثم صورة تحت (داخل الكيرف)
//             const SizedBox(height: 20),
//             _buildTextContent(),
//             Expanded(
//               flex: 3,
//               child: Transform.translate(
//                 offset: const Offset(0, -10),
//                 child: Image.asset(data["image"]!, fit: BoxFit.contain),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTextContent() {
//     return Column(
//       children: [
//         Text(
//           data["title"]!,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textSecondary,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           data["sub"]!,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontSize: 14,
//             color: AppColors.lightTextSecondary,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// class _DotsIndicator extends StatelessWidget {
//   final int activeIndex;
//   const _DotsIndicator({required this.activeIndex});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(3, (index) => Container(
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         height: 8,
//         width: 8,
//         decoration: BoxDecoration(
//           color: index == activeIndex ? AppColors.primaryBackgroundLightColor : AppColors.lightTextSecondary,
//           shape: BoxShape.circle,
//         ),
//       )),
//     );
//   }
// }
//
//
// class HeaderWavePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final w = size.width;
//     final h = size.height;
//     final paint = Paint()
//       ..shader = const LinearGradient(
//         colors: [Color(0xFF277A68), Color(0xFF0E1728)],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//       ).createShader(Rect.fromLTWH(0, 0, w, h))
//       ..style = PaintingStyle.fill;
//
//     Path path = Path();
//     path.lineTo(0, h * 0.7);
//     path.quadraticBezierTo(w * 0.05, h * 0.9, w * 0.20, h * 0.9);
//     path.lineTo(w * 0.80, h * 0.9);
//     path.quadraticBezierTo(w * 0.95, h * 0.9, w, h * 1.0);
//     path.lineTo(w, 0);
//     path.close();
//     canvas.drawPath(path, paint);
//   }
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
//
// // كيرف الصفحة 2 (تحت)
// class BottomHeaderWavePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final w = size.width;
//     final h = size.height;
//     final paint = Paint()
//       ..shader = const LinearGradient(
//         colors: [Color(0xFF0E1728), Color(0xFF277A68)],
//         begin: Alignment.bottomCenter,
//         end: Alignment.topCenter,
//       ).createShader(Rect.fromLTWH(0, 0, w, h))
//       ..style = PaintingStyle.fill;
//
//     Path path = Path();
//     path.moveTo(w, h);
//     path.lineTo(w, h * 0.3);
//     path.quadraticBezierTo(w * 0.95, h * 0.1, w * 0.80, h * 0.1);
//     path.lineTo(w * 0.20, h * 0.1);
//     path.quadraticBezierTo(w * 0.05, h * 0.1, 0, 0);
//     path.lineTo(0, h);
//     path.close();
//     canvas.drawPath(path, paint);
//   }
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }