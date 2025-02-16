import 'package:get/get.dart';

import 'analytics_aes_controller.dart';

class AnalyticsAESBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnalyticsAESController>(
      () => AnalyticsAESController(),
    );
  }
}
