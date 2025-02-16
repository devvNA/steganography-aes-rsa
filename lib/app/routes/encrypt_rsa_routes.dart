import 'package:get/get.dart';

import '../modules/encrypt_rsa/encrypt_rsa_binding.dart';
import '../modules/encrypt_rsa/encrypt_rsa_page.dart';

class EncryptRsaRoutes {
  EncryptRsaRoutes._();

  static const encryptRsa = '/encrypt-rsa';

  static final routes = [
    GetPage(
      name: encryptRsa,
      page: () => const EncryptRsaPage(),
      binding: EncryptRsaBinding(),
    ),
  ];
}
