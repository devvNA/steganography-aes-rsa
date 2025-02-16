// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:steg_aes_rsa/app/routes/analytics_aes_routes.dart';
import 'package:steg_aes_rsa/app/routes/analytics_rsa_routes.dart';
import 'package:steg_aes_rsa/app/routes/decrypt_aes_routes.dart';
import 'package:steg_aes_rsa/app/routes/decrypt_rsa_routes.dart';
import 'package:steg_aes_rsa/app/routes/encrypt_aes_routes.dart';
import 'package:steg_aes_rsa/app/routes/encrypt_rsa_routes.dart';

import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF776FFF),
                  Color(0xFF76C9BE),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 45.0,
              ),
              SafeArea(
                child: Text(
                  "CRYPTOGRAPHY\n(AES & RSA)",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10.0),
              Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              onTap: () {
                                Get.toNamed(EncryptAesRoutes.encryptAes);
                              },
                              child: Image.asset(
                                "assets/lock.png",
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.fill,
                              ).paddingAll(10),
                            ),
                            Text(
                              "ENCRYPTION\n(AES)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          children: [
                            InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              onTap: () {
                                Get.toNamed(EncryptRsaRoutes.encryptRsa);
                              },
                              child: Image.asset(
                                "assets/lock.png",
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.fill,
                              ).paddingAll(10),
                            ),
                            Text(
                              "ENCRYPTION\n(RSA)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              onTap: () {
                                Get.toNamed(DecryptAesRoutes.decryptAes);
                              },
                              child: Image.asset(
                                "assets/unlock.png",
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.fill,
                              ).paddingAll(10),
                            ),
                            Text(
                              "DECRYPTION\n(AES)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          children: [
                            InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              onTap: () {
                                Get.toNamed(DecryptRsaRoutes.decryptRsa);
                              },
                              child: Image.asset(
                                "assets/unlock.png",
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.fill,
                              ).paddingAll(10),
                            ),
                            Text(
                              "DECRYPTION\n(RSA)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              onTap: () {
                                Get.toNamed(AnalyticsAesRoutes.analyticsAes);
                              },
                              child: Image.asset(
                                "assets/analytics.png",
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.fill,
                              ).paddingAll(10),
                            ),
                            Text(
                              "ANALYSIS\n(AES)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        const SizedBox(width: 20.0),
                        Column(
                          children: [
                            InkWell(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              onTap: () {
                                Get.toNamed(AnalyticsRsaRoutes.analyticsRsa);
                              },
                              child: Image.asset(
                                "assets/analytics.png",
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.fill,
                              ).paddingAll(10),
                            ),
                            Text(
                              "ANALYSIS\n(RSA)",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: .0, vertical: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[800],
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              box.erase();
                              // Get.offAllNamed(LoginRoutes.login);
                            },
                            child: const Text("Logout"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
