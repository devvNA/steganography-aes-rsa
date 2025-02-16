import 'package:get/get.dart';

import 'decrypt_aes_controller.dart';

class DecryptAesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DecryptAesController>(
      () => DecryptAesController(),
    );
  }
}
