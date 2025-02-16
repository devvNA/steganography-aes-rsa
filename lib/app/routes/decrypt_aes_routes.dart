import 'package:get/get.dart';

import '../modules/decrypt_aes/decrypt_aes_binding.dart';
import '../modules/decrypt_aes/decrypt_aes_page.dart';

class DecryptAesRoutes {
  DecryptAesRoutes._();

  static const decryptAes = '/decrypt-aes';

  static final routes = [
    GetPage(
      name: decryptAes,
      page: () => const DecryptAesPage(),
      binding: DecryptAesBinding(),
    ),
  ];
}
