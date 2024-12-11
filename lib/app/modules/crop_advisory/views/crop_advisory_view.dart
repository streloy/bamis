import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/crop_advisory_controller.dart';

class CropAdvisoryView extends GetView<CropAdvisoryController> {
  const CropAdvisoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CropAdvisoryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CropAdvisoryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
