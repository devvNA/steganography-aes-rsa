// ignore_for_file: unnecessary_overrides

import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:steg/steg.dart';

class EncryptRsaController extends GetxController {
  final box = GetStorage();
  final messageController = TextEditingController();
  final publicKeyController = TextEditingController();
  final privateKeyController = TextEditingController();
  final isLoading = false.obs;
  final tempImg = Rx<XFile?>(null);
  final resultBytes = "No results yet".obs;
  final processingTime = 0.obs;
  final isGrayScale = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> generateKey() async {
    box.erase();
    isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
    final keypairNew = Steganograph.generateKeypair();

    publicKeyController.text = keypairNew.publicKey;
    privateKeyController.text = keypairNew.privateKey;

    box.write('PUBLIC_KEY', publicKeyController.text);
    box.write('PRIVATE_KEY', privateKeyController.text);

    dev.log(box.read('PUBLIC_KEY'));
    dev.log(box.read('PRIVATE_KEY'));

    update();
  }

  Future<void> pickImage() async {
    isLoading.value = true;
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    tempImg.value = pickedImage;
    isLoading.value = false;
  }

  Future<void> steganoRequest() async {
    // Validate form first
    if (publicKeyController.text.isEmpty ||
        tempImg.value == null ||
        messageController.text.isEmpty) {
      if (Get.isSnackbarOpen) return;
      Get.snackbar(
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.red[700],
        'Error',
        'Keys and message must be filled',
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      // Request permission first

      // Check and request permission for Android 10 and above
      if (Platform.isAndroid) {
        if (await Permission.manageExternalStorage.request().isGranted) {
          if (tempImg.value != null && messageController.text.isNotEmpty) {
            final stopwatch = Stopwatch()..start();

            // Encode message into image
            final file = await Steganograph.encode(
              image: File(tempImg.value!.path),
              message: messageController.text,
              encryptionKey: publicKeyController.text,
              encryptionType: EncryptionType.asymmetric,
              outputFilePath: isGrayScale.value
                  ? '/storage/emulated/0/Download/rsa_encryption_gray.png'
                  : '/storage/emulated/0/Download/rsa_encryption.png',
            );

            stopwatch.stop();
            processingTime.value = stopwatch.elapsedMilliseconds;

            // Read image bytes
            final bytes = await file!.readAsBytes();
            final image = img.decodeImage(bytes);

            if (image != null) {
              // Get cipher text from steganography result
              final extractedMessage = await Steganograph.decode(
                image: file,
                encryptionKey: privateKeyController.text,
                encryptionType: EncryptionType.asymmetric,
              );
              if (isGrayScale.value) {
                final random = Random();

                // Iterasi pixel dengan metode yang lebih efisien
                for (var y = 0; y < image.height; y++) {
                  for (var x = 0; x < image.width; x++) {
                    final pixel = image.getPixel(x, y);

                    // Konversi ke Grayscale menggunakan rumus luminosity
                    final grayscaleValue =
                        (0.299 * pixel.r + 0.587 * pixel.g + 0.114 * pixel.b)
                            .toInt();

                    // Tambahkan noise
                    final noiseIntensity = 20; // Dapat disesuaikan
                    final noisyGrayscale = (grayscaleValue +
                            random.nextInt(noiseIntensity * 2) -
                            noiseIntensity)
                        .clamp(0, 255);

                    // Buat pixel grayscale dengan noise
                    final newPixel = img.ColorFloat32.rgb(
                        noisyGrayscale, noisyGrayscale, noisyGrayscale);

                    image.setPixel(x, y, newPixel);
                  }
                }
              }

              // Encrypt message using base64 for display
              final messageBytes = utf8.encode(extractedMessage!);
              resultBytes.value = base64Encode(messageBytes);
              // Save the manipulated image
              final manipulatedBytes = img.encodePng(image);
              await File(file.path).writeAsBytes(manipulatedBytes);
            }

            if (Get.isSnackbarOpen) return;
            Get.snackbar(
              margin: const EdgeInsets.all(16),
              backgroundColor: Colors.green[600],
              'Success',
              "Encryption result has been saved to /storage/emulated/0/Download/",
              colorText: Colors.white,
            );

            dev.log(resultBytes.value.toString());
            isLoading.value = false;
          } else {
            isLoading.value = false;
            if (Get.isSnackbarOpen) return;
            Get.snackbar(
              margin: const EdgeInsets.all(16),
              backgroundColor: Colors.red[700],
              'Error',
              "Please complete message and image data",
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        } else {
          if (Get.isSnackbarOpen) return;
          Get.snackbar(
            margin: const EdgeInsets.all(16),
            backgroundColor: Colors.red[700],
            'Error',
            'Storage permission is required to save files',
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }
      }
    } on Exception catch (e) {
      isLoading.value = false;

      if (Get.isSnackbarOpen) return;
      Get.snackbar(
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.red[700],
        'Error',
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
