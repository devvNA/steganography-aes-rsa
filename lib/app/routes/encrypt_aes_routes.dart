import 'package:get/get.dart';

import '../modules/encrypt_aes/encrypt_aes_binding.dart';
import '../modules/encrypt_aes/encrypt_aes_page.dart';

class EncryptAesRoutes {
  EncryptAesRoutes._();

  static const encryptAes = '/encrypt-aes';

  static final routes = [
    GetPage(
      name: encryptAes,
      page: () => const EncryptAesPage(),
      binding: EncryptAesBinding(),
    ),
  ];
}
