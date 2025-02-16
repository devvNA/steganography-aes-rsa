import 'package:get/get.dart';

import 'analytics_rsa_controller.dart';

class AnalyticsRSABinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalyticsRSAController>(
      () => AnalyticsRSAController(),
    );
  }
}
