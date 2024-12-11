import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/farm_metrics_controller.dart';

class FarmMetricsView extends GetView<FarmMetricsController> {
  const FarmMetricsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FarmMetricsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FarmMetricsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
