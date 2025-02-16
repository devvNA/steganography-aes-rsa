import 'package:get/get.dart';

import '../modules/decrypt_rsa/decrypt_rsa_binding.dart';
import '../modules/decrypt_rsa/decrypt_rsa_page.dart';

class DecryptRsaRoutes {
  DecryptRsaRoutes._();

  static const decryptRsa = '/decrypt-rsa';

  static final routes = [
    GetPage(
      name: decryptRsa,
      page: () => const DecryptRsaPage(),
      binding: DecryptRsaBinding(),
    ),
  ];
}
