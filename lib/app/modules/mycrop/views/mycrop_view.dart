import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mycrop_controller.dart';

class MycropView extends GetView<MycropController> {
  const MycropView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MycropView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MycropView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
