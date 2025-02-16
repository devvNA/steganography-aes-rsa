import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steg/steg.dart';

class DecryptRsaController extends GetxController {
  final box = GetStorage();
  final rsaPrivateKeyController = TextEditingController();
  final rsaEncryptedImage = Rx<XFile?>(null);
  final rsaExtractedMessage = ''.obs;
  final isLoading = false.obs;
  final processingRSATime = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickRSAImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      rsaEncryptedImage.value = image;
      rsaPrivateKeyController.text = box.read('PRIVATE_KEY');
      log(image.path);
    }
  }

  Future<void> decryptRSAMessage() async {
    isLoading.value = true;

    try {
      final stopwatch = Stopwatch()..start();
      final embeddedMessage = await Steganograph.decode(
        image: File(rsaEncryptedImage.value!.path),
        encryptionKey: box.read('PRIVATE_KEY'),
        encryptionType: EncryptionType.asymmetric,
      );
      rsaExtractedMessage.value = embeddedMessage!;
      stopwatch.stop();
      processingRSATime.value = stopwatch.elapsedMilliseconds;
    } catch (e) {
      log(e.toString());

      rsaExtractedMessage.value = '';

      if (Get.isSnackbarOpen) return;
      Get.snackbar(
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.red[700],
        'Error',
        "File not supported for decoding process",
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
