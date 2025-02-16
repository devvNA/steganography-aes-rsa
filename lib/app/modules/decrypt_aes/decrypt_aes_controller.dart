import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:steg/steg.dart';

class DecryptAesController extends GetxController {
  final aesKeyController = TextEditingController();
  final aesEncryptedImage = Rx<XFile?>(null);
  final aesExtractedMessage = ''.obs;
  final isLoading = false.obs;
  final processingAESTime = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> pickAESImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      aesEncryptedImage.value = image;
      log(image.path);
    }
  }

  Future<void> decryptAESMessage() async {
    isLoading.value = true;

    try {
      final stopwatch = Stopwatch()..start();
      final embeddedMessage = await Steganograph.decode(
        image: File(aesEncryptedImage.value!.path),
        encryptionKey: aesKeyController.text,
      );
      aesExtractedMessage.value = embeddedMessage!;
      stopwatch.stop();
      processingAESTime.value = stopwatch.elapsedMilliseconds;
    } catch (e) {
      log(e.toString());
      aesExtractedMessage.value = '';
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
  void onClose() {
    super.onClose();
  }
}
