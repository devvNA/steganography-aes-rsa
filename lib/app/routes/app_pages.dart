import 'package:steg_aes_rsa/app/routes/analytics_aes_routes.dart';
import 'package:steg_aes_rsa/app/routes/analytics_rsa_routes.dart';

import 'decrypt_aes_routes.dart';
import 'decrypt_rsa_routes.dart';
import 'encrypt_aes_routes.dart';
import 'encrypt_rsa_routes.dart';
import 'home_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/home';

  static final routes = [
    ...HomeRoutes.routes,
    ...EncryptAesRoutes.routes,
    ...EncryptRsaRoutes.routes,
    ...DecryptAesRoutes.routes,
    ...DecryptRsaRoutes.routes,
    ...AnalyticsRsaRoutes.routes,
    ...AnalyticsAesRoutes.routes,
  ];
}
