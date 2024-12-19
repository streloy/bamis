import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pest_disease_alert_detail_controller.dart';
import 'package:intl/intl.dart';

class PestDiseaseAlertDetailView
    extends GetView<PestDiseaseAlertDetailController> {
  const PestDiseaseAlertDetailView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(()=> Text(controller.name.value)),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${controller.data['name']}", style: TextStyle(fontSize: 20)),
              Text("Scientific Name" + ": " + controller.data['scientific_name']),
              Text("Pathogen Name" + ": " + toBeginningOfSentenceCase(controller.data['pathogen_class'])),
              SizedBox(height: 16),
              Container(
                child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.network(controller.data['default_image'], height: 200, width: double.infinity, fit: BoxFit.cover)),
              ),
              SizedBox(height: 16),
              Text("Symptoms", style: TextStyle(fontSize: 20)),
              Text(controller.data['bullet_points']),
              SizedBox(height: 16),
              Text(controller.data['symptoms']),



              SizedBox(height: 16),
              Text("Preventive Measure", style: TextStyle(fontSize: 20)),
              Text(controller.data['preventive_measures'], textAlign: TextAlign.justify),

              SizedBox(height: 16),
              Text("Organic Control", style: TextStyle(fontSize: 20)),
              Text(controller.data['alternative_treatment'], textAlign: TextAlign.justify),

              SizedBox(height: 16),
              Text("Chemical Control", style: TextStyle(fontSize: 20)),
              Text(controller.data['chemical_treatment'], textAlign: TextAlign.justify),

              SizedBox(height: 16),
              Text("What caused it", style: TextStyle(fontSize: 20)),
              Text(controller.data['triggers'], textAlign: TextAlign.justify),
            ],
          ),
        ),
      ),
    );
  }
}
