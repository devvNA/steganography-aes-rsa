import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'analytics_rsa_controller.dart';

class AnalyticsRSAPage extends GetView<AnalyticsRSAController> {
  const AnalyticsRSAPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        title: const Text('Analysis (RSA)'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Image Comparison',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        return Row(
                          children: [
                            Expanded(
                              child: _buildImageSelector(
                                'Original Image',
                                controller.originalIMG,
                                controller.pickOriginalImage,
                                controller.originalFileSize,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildImageSelector(
                                'Modified Image',
                                controller.modifiedIMG,
                                controller.pickModifiedImage,
                                controller.modifiedFileSize,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Analysis Results',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: controller.calculateMetrics,
                            icon: const Icon(Icons.analytics),
                            label: const Text('Analyze'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: Column(
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 16),
                                  Text(
                                    'Analyzing image...',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildMetricCard(
                              'MSE (Mean Square Error)',
                              controller.mseValue.value.toStringAsFixed(4),
                              'Lower MSE value indicates less difference between images',
                              Icons.compare,
                              Colors.green[100]!,
                            ),
                            const SizedBox(height: 16),
                            _buildMetricCard(
                              'PSNR (Peak Signal-to-Noise Ratio)',
                              '${controller.psnrValue.value.toStringAsFixed(2)} dB',
                              'Higher PSNR value indicates better image quality',
                              Icons.signal_cellular_alt,
                              Colors.blue[100]!,
                            ),
                            // const SizedBox(height: 16),
                            // _buildMetricCard(
                            //   'DWT Energy',
                            //   '${controller.dwtEnergy.value.toStringAsFixed(2)} dB',
                            //   'Higher Energy value indicates more information contained in the image',
                            //   Icons.bolt,
                            //   Colors.orange[100]!,
                            // ),
                            // const SizedBox(height: 16),
                            // _buildMetricCard(
                            //   'DWT Entropy',
                            //   '${controller.dwtEntropy.value.toStringAsFixed(2)} dB',
                            //   'Higher Entropy value indicates more variation/complexity in the image',
                            //   Icons.auto_graph,
                            //   Colors.green[100]!,
                            // ),
                            const SizedBox(height: 16),
                            _buildMetricCard(
                              'Processing Time',
                              '${controller.processingTime.value} milisecond',
                              'Time taken to process the image',
                              Icons.timer,
                              Colors.purple[100]!,
                            ),
                            // _buildMetricCard(
                            //   'Image Size',
                            //   '${controller.imageSize.value?.width.toInt() ?? 0} x ${controller.imageSize.value?.height.toInt() ?? 0}',
                            //   'Image dimensions in pixels',
                            //   Icons.aspect_ratio,
                            //   Colors.purple[100]!,
                            // ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSelector(
    String title,
    Rx<File?> imageFile,
    VoidCallback onPick,
    Rx<int> fileSize,
  ) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Obx(() => imageFile.value != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(imageFile.value!.path),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_outlined,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "No image selected",
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                )),
        ),
        const SizedBox(height: 12),
        Text(
          'File Size: ${fileSize.value} bytes',
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 12),
        ElevatedButton.icon(
          onPressed: onPick,
          icon: const Icon(Icons.add_photo_alternate),
          label: Text('Select $title'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String description,
    IconData icon,
    Color bgColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
