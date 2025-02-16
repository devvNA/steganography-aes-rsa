import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'encrypt_rsa_controller.dart';

class EncryptRsaPage extends GetView<EncryptRsaController> {
  const EncryptRsaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        title: const Text('RSA Encryption'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Stack(
          children: [
            SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: GetBuilder<EncryptRsaController>(builder: (_) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'RSA Keys',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller:
                                            controller.publicKeyController,
                                        maxLines: controller.publicKeyController
                                                .text.isEmpty
                                            ? 1
                                            : 13,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: 'Public Key',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      TextField(
                                        controller:
                                            controller.privateKeyController,
                                        maxLines: controller
                                                .privateKeyController
                                                .text
                                                .isEmpty
                                            ? 1
                                            : 52,
                                        enabled: false,
                                        decoration: InputDecoration(
                                          labelText: 'Private Key',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[100],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12.0),
                                IconButton(
                                  onPressed: controller.generateKey,
                                  icon: const Icon(Icons.key),
                                  tooltip: 'Generate Key',
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.blue[50],
                                    padding: const EdgeInsets.all(12),
                                  ),
                                ),
                              ],
                            ),
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Message & Image',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: controller.messageController,
                              decoration: InputDecoration(
                                labelText: 'Enter Message',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                filled: true,
                                fillColor: Colors.grey[50],
                              ),
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                    ),
                                    child: controller.tempImg.value != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Image.file(
                                              File(controller
                                                  .tempImg.value!.path),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.image_outlined,
                                                    size: 48,
                                                    color: Colors.grey[400]),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "No image selected",
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                ElevatedButton.icon(
                                  onPressed: controller.isLoading.value
                                      ? null
                                      : controller.pickImage,
                                  icon: const Icon(Icons.image),
                                  label: const Text('Select Image'),
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
                            const SizedBox(height: 16),
                            const Text(
                              'Gray Scale',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(() {
                              return Switch(
                                value: controller.isGrayScale.value,
                                activeColor: Color(0xFF776FFF),
                                onChanged: (value) {
                                  controller.isGrayScale.value = value;
                                  log('isGrayScale: ${controller.isGrayScale.value}');
                                },
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.steganoRequest,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Encrypt',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Encryption Result',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Cipher Text:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Obx(() => Text(
                                        controller.resultBytes.value,
                                        maxLines: 3,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    'Encryption Time:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Obx(() => Text(
                                        "${controller.processingTime.value} milliseconds",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            if (controller.isLoading.value)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
    );
  }
}
