import 'package:flutter/material.dart';
import '../../core/widgets/app_container.dart';
import '../detection/presentation/widgets/detection_bottom_nav.dart';

class RealOrFakeQuizScreen extends StatefulWidget {
  const RealOrFakeQuizScreen({super.key});

  @override
  State<RealOrFakeQuizScreen> createState() => _RealOrFakeQuizScreenState();
}

class _RealOrFakeQuizScreenState extends State<RealOrFakeQuizScreen> {
  // 0: لم يتم الاختيار | 1: اختار Real (خطأ) | 2: اختار Fake (صح)
  int selectedAnswer = 0;

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBgColor = Color(0xFF0A1220);

    return Scaffold(
      bottomNavigationBar:BottomNav(activePage: 'Learn',) ,
      backgroundColor: scaffoldBgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Real or Fake ?",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// 1. النص التوضيحي العلوي
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 16, height: 1.4),
                children: [
                  TextSpan(text: "Test your skills: Can you tell if this media\n"),
                  TextSpan(
                    text: "is real or fake ?",
                    style: TextStyle(color: Color(0xFF38A18E), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 35),

            /// 2. منطقة عرض الفيديو
            SizedBox(
              height: 250,
              width: double.infinity,
              child: AppContainer(
                padding: 0,
                borderRadius: 20,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(
                      'assets/images/quiz.png', // تأكدي من وجود الصورة في هذا المسار
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                // أيقونة تشغيل الفيديو
                const Icon(
                  Icons.play_circle_fill,
                  color: Colors.transparent,
                  size: 65,
                ),
              ],
            ),
          ),
        ),

            const SizedBox(height: 40),

            /// 3. أزرار الاختيار (Real & Fake)
            Row(
              children: [
                // زر Real
                _buildOptionButton(
                  title: "Real",
                  color: const Color(0xFF237672),
                  onTap: () {
                    setState(() {
                      selectedAnswer = 1; // إجابة خاطئة لهذا الفيديو
                    });
                  },
                ),
                const SizedBox(width: 15),
                // زر Fake
                _buildOptionButton(
                  title: "Fake",
                  color: const Color(0xFFE84C44),
                  onTap: () {
                    setState(() {
                      selectedAnswer = 2; // إجابة صحيحة لهذا الفيديو
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),

            /// 4. عرض النتيجة (تظهر فقط بعد الضغط على أحد الأزرار)
            if (selectedAnswer != 0)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: selectedAnswer == 2
                    ? _buildResultCard(
                  isCorrect: true,
                  title: "Correct! ",
                  subtitle: "you identified this media correctly.",
                  color: const Color(0xFF38A18E),
                  imagePath: 'assets/images/check (2) 1.png', // استبدليها بمسار صورتك
                )
                    : _buildResultCard(
                  isCorrect: false,
                  title: "oops! wrong answer, ",
                  subtitle: "please try again.",
                  color: const Color(0xFFE84C44),
                  imagePath: 'assets/images/icons8-wrong-50.png', // استبدليها بمسار صورتك
                ),
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// ويدجت مساعدة لبناء الأزرار (Real/Fake)
  Widget _buildOptionButton({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  /// ويدجت بناء كارت النتيجة مع استخدام "صورة" بدل الأيقونة
  Widget _buildResultCard({
    required bool isCorrect,
    required String title,
    required String subtitle,
    required Color color,
    required String imagePath,
  }) {
    return Container(
      key: ValueKey(isCorrect), // ضروري لعمل الـ AnimatedSwitcher بشكل صحيح
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1725),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        children: [
          // عرض الصورة المختارة (صح أو خطأ)
          Image.asset(
            imagePath,
            width: 45,
            height: 45,
            fit: BoxFit.contain,
            // معالجة الخطأ في حال لم يتم العثور على الصورة
            errorBuilder: (context, error, stackTrace) => Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: color,
              size: 40,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.4,
                ),
                children: [
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(text: subtitle),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}