import 'package:get/get.dart';

import '../modules/analytics_aes/analytics_aes_binding.dart';
import '../modules/analytics_aes/analytics_aes_page.dart';

class AnalyticsAesRoutes {
  AnalyticsAesRoutes._();

  static const analyticsAes = '/analytics-aes';

  static final routes = [
    GetPage(
      name: analyticsAes,
      page: () => const AnalyticsAESPage(),
      binding: AnalyticsAESBinding(),
    ),
  ];
}
