import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'decrypt_rsa_controller.dart';

class DecryptRsaPage extends GetView<DecryptRsaController> {
  const DecryptRsaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 5,
        title: const Text('RSA Decryption'),
        centerTitle: true,
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(Icons.security, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 8),
                  const Text(
                    'RSA Decryption',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                maxLines:
                    controller.rsaPrivateKeyController.text.isNotEmpty ? 3 : 1,
                enabled: false,
                controller: controller.rsaPrivateKeyController,
                decoration: InputDecoration(
                  labelText: 'Private Key',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.key),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    if (controller.rsaEncryptedImage.value != null)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.file(
                          File(controller.rsaEncryptedImage.value!.path),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: ElevatedButton.icon(
                        onPressed: controller.pickRSAImage,
                        icon: const Icon(Icons.image),
                        label: Text(
                          controller.rsaEncryptedImage.value != null
                              ? 'Change RSA Image'
                              : 'Select RSA Image',
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.decryptRSAMessage,
                  icon: const Icon(Icons.lock_open),
                  label: const Text('Decrypt RSA'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEA5455),
                  ),
                ),
              ),
              if (controller.rsaExtractedMessage.isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.message, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            'RSA Message:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SelectableText(
                        controller.rsaExtractedMessage.value,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Divider(height: 24),
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.grey),
                          const SizedBox(width: 8),
                          const Text(
                            'Decryption Time:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${controller.processingRSATime.value} milliseconds",
                            style: const TextStyle(
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
        );
      }),
    );
  }
}
