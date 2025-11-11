import 'dart:async';
import 'package:get/get.dart';
import '../../app/routes/app_routes.dart';

class OnboardingController extends GetxController {
  final RxDouble cloudOffsetX = 0.0.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startCloudAnimation();
    _timer = Timer(const Duration(seconds: 4), () {
      if (Get.currentRoute != Routes.weatherDetails) {
        Get.offAllNamed(Routes.weatherDetails);
      }
    });
  }

  void _startCloudAnimation() {
    // Animate cloud movement horizontally in a loop-like fashion
    ever<double>(cloudOffsetX, (_) {});
    Future.doWhile(() async {
      for (double x = -1.0; x <= 1.0; x += 0.02) {
        await Future<void>.delayed(const Duration(milliseconds: 16));
        cloudOffsetX.value = x;
      }
      return true;
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}


