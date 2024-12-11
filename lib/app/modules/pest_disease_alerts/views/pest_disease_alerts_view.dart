import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pest_disease_alerts_controller.dart';

class PestDiseaseAlertsView extends GetView<PestDiseaseAlertsController> {
  const PestDiseaseAlertsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PestDiseaseAlertsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PestDiseaseAlertsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
