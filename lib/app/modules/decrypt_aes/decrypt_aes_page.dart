import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'decrypt_aes_controller.dart';

class DecryptAesPage extends GetView<DecryptAesController> {
  const DecryptAesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        title: const Text('AES Decryption'),
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Icon(Icons.security,
                          color: Theme.of(context).primaryColor),
                      SizedBox(width: 8),
                      Text(
                        'AES Decryption',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: controller.aesKeyController,
                    decoration: InputDecoration(
                      labelText: 'AES Key',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.key),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        if (controller.aesEncryptedImage.value != null)
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                            child: Image.file(
                              File(controller.aesEncryptedImage.value!.path),
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Container(
                          padding: EdgeInsets.all(12),
                          child: ElevatedButton.icon(
                            onPressed: controller.pickAESImage,
                            icon: Icon(Icons.image),
                            label: Text(
                              controller.aesEncryptedImage.value != null
                                  ? 'Change AES Image'
                                  : 'Select AES Image',
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton.icon(
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.decryptAESMessage,
                      icon: Icon(Icons.lock_open),
                      label: Text('Decrypt AES'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFEA5455),
                      ),
                    ),
                  ),
                  if (controller.aesExtractedMessage.isNotEmpty) ...[
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.message, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                'AES Message:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          SelectableText(
                            controller.aesExtractedMessage.value,
                            style: TextStyle(fontSize: 16),
                          ),
                          Divider(height: 24),
                          Row(
                            children: [
                              Icon(Icons.timer, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                'Decryption Time:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${controller.processingAESTime.value} milliseconds",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
