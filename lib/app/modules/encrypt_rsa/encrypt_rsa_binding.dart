import 'package:get/get.dart';

import 'encrypt_rsa_controller.dart';

class EncryptRsaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EncryptRsaController>(
      () => EncryptRsaController(),
    );
  }
}
