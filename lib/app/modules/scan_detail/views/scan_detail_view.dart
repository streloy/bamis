import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/scan_detail_controller.dart';

class ScanDetailView extends GetView<ScanDetailController> {
  const ScanDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ScanDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ScanDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
