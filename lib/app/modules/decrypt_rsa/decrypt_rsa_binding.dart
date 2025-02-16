import 'package:get/get.dart';

import 'decrypt_rsa_controller.dart';

class DecryptRsaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DecryptRsaController>(
      () => DecryptRsaController(),
    );
  }
}
