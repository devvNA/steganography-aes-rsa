// ignore_for_file: unused_local_variable, unnecessary_null_comparison

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class AnalyticsAESController extends GetxController {
  final originalIMG = Rx<File?>(null);
  final modifiedIMG = Rx<File?>(null);
  final isLoading = false.obs;
  final mseValue = 0.0.obs;
  final psnrValue = 0.0.obs;
  // final dwtEnergy = 0.0.obs;
  // final dwtEntropy = 0.0.obs;
  final imageSize = Rx<Size?>(null);
  final originalFileSize = Rx<int>(0);
  final modifiedFileSize = Rx<int>(0);
  final processingTime = 0.obs;

  Future<void> pickOriginalImage() async {
    isLoading.value = true;
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      originalIMG.value = File(pickedImage.path);
      // Get image dimensions
      final image = img.decodeImage(await File(pickedImage.path).readAsBytes());
      if (image != null) {
        imageSize.value = Size(image.width.toDouble(), image.height.toDouble());
      }
      originalFileSize.value = await File(pickedImage.path).length();
    }
    isLoading.value = false;
  }

  Future<void> pickModifiedImage() async {
    isLoading.value = true;
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      modifiedIMG.value = File(pickedImage.path);
      modifiedFileSize.value = await File(pickedImage.path).length();
    }
    isLoading.value = false;
  }

  Future<void> calculateMetrics() async {
    try {
      if (originalIMG.value == null || modifiedIMG.value == null) {
        if (Get.isSnackbarOpen) return;
        Get.snackbar(
          margin: const EdgeInsets.all(16),
          backgroundColor: Colors.red[700],
          'Error',
          'Please select both images first',
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      isLoading.value = true;

      // Tambahkan pengukuran waktu mulai
      final stopwatch = Stopwatch()..start();

      // Calculate MSE and PSNR
      mseValue.value =
          await calculateMSE(originalIMG.value!, modifiedIMG.value!);
      psnrValue.value = calculatePSNR(mseValue.value);

      // Hentikan stopwatch dan simpan durasi dalam milliseconds

      // Calculate DWT metrics
      // final dwtMetrics = await calculateDWTMetrics(modifiedIMG.value!);
      // dwtEnergy.value = dwtMetrics['energy']!;
      // dwtEntropy.value = dwtMetrics['entropy']!;
      stopwatch.stop();
      processingTime.value = stopwatch.elapsedMilliseconds;
      String quality = '';
      if (psnrValue.value > 40) {
        quality = 'Excellent';
      } else if (psnrValue.value > 30) {
        quality = 'Good';
      } else if (psnrValue.value > 20) {
        quality = 'Fair';
      } else {
        quality = 'Poor';
      }

      if (Get.isSnackbarOpen) return;
      Get.snackbar(
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.green[600],
        'Success',
        'MSE: ${mseValue.value.toStringAsFixed(4)}\n'
            'PSNR: ${psnrValue.value.toStringAsFixed(2)} dB\n'
            'Image Size: ${imageSize.value?.width.toInt() ?? 0} x ${imageSize.value?.height.toInt() ?? 0}\n'
            'Processing Time: ${processingTime.value} ms',
        // 'DWT Energy: ${dwtEnergy.value.toStringAsFixed(4)}\n'
        // 'DWT Entropy: ${dwtEntropy.value.toStringAsFixed(4)}\n',
        // 'Quality: $quality',
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      if (Get.isSnackbarOpen) return;
      Get.snackbar(
        margin: const EdgeInsets.all(16),
        backgroundColor: Colors.red[700],
        'Error',
        e.toString(),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // New DWT-related methods
  // Future<Map<String, double>> calculateDWTMetrics(File image) async {
  //   try {
  //     final bytes = await image.readAsBytes();
  //     final decodedImage = img.decodeImage(bytes);

  //     if (decodedImage == null) {
  //       throw Exception('Failed to read image for DWT analysis');
  //     }

  //     // Convert to grayscale for DWT analysis
  //     final grayscale = img.grayscale(decodedImage);

  //     // Perform 1-level DWT
  //     final dwtCoefficients = performDWT(grayscale);

  //     // Calculate energy and entropy from DWT coefficients
  //     final energy = calculateDWTEnergy(dwtCoefficients);
  //     final entropy = calculateDWTEntropy(dwtCoefficients);

  //     return {
  //       'energy': energy,
  //       'entropy': entropy,
  //     };
  //   } catch (e) {
  //     log('Error calculating DWT metrics: $e');
  //     rethrow;
  //   }
  // }

  // List<List<double>> performDWT(img.Image grayscale) {
  //   final width = grayscale.width;
  //   final height = grayscale.height;
  //   final coefficients = List.generate(
  //     height,
  //     (y) => List.generate(
  //       width,
  //       (x) => grayscale.getPixel(x, y).r.toDouble(),
  //     ),
  //   );

  //   // Horizontal transformation
  //   for (int y = 0; y < height; y++) {
  //     for (int x = 0; x < width ~/ 2; x++) {
  //       final k = x * 2;
  //       final avg =
  //           (coefficients[y][k] + coefficients[y][k + 1]) / math.sqrt(2);
  //       final diff =
  //           (coefficients[y][k] - coefficients[y][k + 1]) / math.sqrt(2);
  //       coefficients[y][k] = avg;
  //       coefficients[y][k + 1] = diff;
  //     }
  //   }

  //   // Vertical transformation
  //   for (int x = 0; x < width; x++) {
  //     for (int y = 0; y < height ~/ 2; y++) {
  //       final k = y * 2;
  //       final avg =
  //           (coefficients[k][x] + coefficients[k + 1][x]) / math.sqrt(2);
  //       final diff =
  //           (coefficients[k][x] - coefficients[k + 1][x]) / math.sqrt(2);
  //       coefficients[k][x] = avg;
  //       coefficients[k + 1][x] = diff;
  //     }
  //   }

  //   return coefficients;
  // }

  // double calculateDWTEnergy(List<List<double>> coefficients) {
  //   double energy = 0.0;
  //   final height = coefficients.length;
  //   final width = coefficients[0].length;

  //   for (int y = 0; y < height; y++) {
  //     for (int x = 0; x < width; x++) {
  //       energy += coefficients[y][x] * coefficients[y][x];
  //     }
  //   }

  //   return energy / (width * height);
  // }

  Future<double> calculateMSE(File original, File modified) async {
    try {
      final originalBytes = await original.readAsBytes();
      final modifiedBytes = await modified.readAsBytes();

      final originalImage = img.decodeImage(originalBytes);
      final modifiedImage = img.decodeImage(modifiedBytes);

      if (originalImage == null || modifiedImage == null) {
        throw Exception('Failed to read images');
      }

      if (originalImage.width != modifiedImage.width ||
          originalImage.height != modifiedImage.height) {
        throw Exception('Both images must have the same dimensions');
      }

      double sumSquaredError = 0.0;
      int width = originalImage.width;
      int height = originalImage.height;
      int totalPixels = width * height;

      final img1 = originalImage.convert(numChannels: 4);
      final img2 = modifiedImage.convert(numChannels: 4);

      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          final originalPixel = img1.getPixel(x, y);
          final modifiedPixel = img2.getPixel(x, y);

          final diffR =
              (originalPixel.r.toDouble() - modifiedPixel.r.toDouble());
          final diffG =
              (originalPixel.g.toDouble() - modifiedPixel.g.toDouble());
          final diffB =
              (originalPixel.b.toDouble() - modifiedPixel.b.toDouble());

          sumSquaredError += diffR * diffR + diffG * diffG + diffB * diffB;
        }
      }

      final mse = sumSquaredError / totalPixels; // Corrected
      return mse;
    } catch (e) {
      log('Error calculating MSE: $e');
      rethrow;
    }
  }

  double calculatePSNR(double mse) {
    if (mse < 1e-10) {
      return 100.0;
    }

    try {
      final psnr = 10 * math.log(255) - 10 * math.log(mse); // Corrected
      return psnr.isFinite ? psnr : 100.0;
    } catch (e) {
      log('Error calculating PSNR: $e');
      return 0.0;
    }
  }

  // double calculateDWTEntropy(List<List<double>> coefficients) {
  //   final histogram = <int, int>{};
  //   final height = coefficients.length;
  //   final width = coefficients[0].length;
  //   final totalPixels = width * height;

  //   for (int y = 0; y < height; y++) {
  //     for (int x = 0; x < width; x++) {
  //       final value = coefficients[y][x].round();
  //       histogram[value] = (histogram[value] ?? 0) + 1;
  //     }
  //   }

  //   double entropy = 0.0;
  //   for (var count in histogram.values) {
  //     final probability = count / totalPixels;
  //     entropy -= probability * math.log(probability); // Corrected
  //   }

  //   return entropy;
  // }
}
