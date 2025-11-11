import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Getx/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB), // sky blue
      body: Stack(
        children: [
          // Sun
          Positioned(
            top: size.height * 0.1,
            right: size.width * 0.1,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFD54F),
              ),
            ),
          ),
          // Clouds animation
          Obx(() {
            final dx = controller.cloudOffsetX.value;
            return Transform.translate(
              offset: Offset(dx * size.width * 0.5, -10),
              child: Align(
                alignment: Alignment.topLeft,
                child: _Cloud(width: size.width * 0.6, height: 90),
              ),
            );
          }),
          Obx(() {
            final dx = -controller.cloudOffsetX.value;
            return Transform.translate(
              offset: Offset(dx * size.width * 0.4, 40),
              child: Align(
                alignment: Alignment.topRight,
                child: _Cloud(width: size.width * 0.45, height: 70),
              ),
            );
          }),
          // Title
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Weatherly',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 44,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Your daily forecast at a glance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Cloud extends StatelessWidget {
  final double width;
  final double height;
  const _Cloud({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _CloudPainter(),
      ),
    );
  }
}

class _CloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final r = size.height / 2;
    final centers = [
      Offset(r * 1.2, r),
      Offset(r * 2.0, r * 0.7),
      Offset(r * 2.7, r),
      Offset(r * 3.5, r * 0.9),
    ];
    for (final c in centers) {
      canvas.drawCircle(c, r, paint);
    }
    final rect = Rect.fromLTWH(r * 1.2, r * 0.8, r * 2.3, r * 1.0);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(r)),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


