import 'package:get/get.dart';

import 'encrypt_aes_controller.dart';

class EncryptAesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EncryptAesController>(
      () => EncryptAesController(),
    );
  }
}
