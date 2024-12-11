import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/articles_controller.dart';

class ArticlesView extends GetView<ArticlesController> {
  const ArticlesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ArticlesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ArticlesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
