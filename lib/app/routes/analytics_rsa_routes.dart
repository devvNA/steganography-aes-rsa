import 'package:get/get.dart';

import '../modules/analytics_rsa/analytics_rsa_binding.dart';
import '../modules/analytics_rsa/analytics_rsa_page.dart';

class AnalyticsRsaRoutes {
  AnalyticsRsaRoutes._();

  static const analyticsRsa = '/analytics-rsa';

  static final routes = [
    GetPage(
      name: analyticsRsa,
      page: () => const AnalyticsRSAPage(),
      binding: AnalyticsRSABinding(),
    ),
  ];
}
