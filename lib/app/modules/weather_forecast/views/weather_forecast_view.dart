import 'package:bamis/utils/ApiURL.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/weather_forecast_controller.dart';

class WeatherForecastView extends GetView<WeatherForecastController> {
  const WeatherForecastView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: controller.changeLocation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Weather Forecast", style: TextStyle(fontSize: 16)),
              Row(
                children: [
                  Obx(() => Text(controller.locationName.value, style: TextStyle(fontSize: 12)) ),
                  SizedBox(width: 4),
                  Icon(Icons.location_pin, size: 12)
                ],
              ),
            ],
          ),
        ),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(()=> Text("Weather Forecast For Next ${controller.forecast.value.length} Days", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
            Expanded(
              child: Obx(()=> ListView.builder (
                itemCount: controller.forecast.value.length,
                itemBuilder: (context, data) {
                  dynamic item = controller.forecast.value[data];
                  var icon = ApiURL.base_url_image + "assets/weather_icons/" + item['icon'];
                  var type = item['type'];
                  var tempMax = item['temp']['val_max'];
                  var tempMin = item['temp']['val_min'];
                  var tempUnit = item['temp_unit'];
                  var rf = item['rf']['val_avg'];
                  var rfUnit = item['rf_unit'];
                  var rh = item['rh']['val_avg'];
                  var rhUnit = item['rh_unit'];
                  var windspd = item['windspd']['val_avg'];
                  var windspdUnit = item['windspd_unit'];
                  return Card(
                    color: AppColors().app_primary_bg_dark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: AppColors().app_primary,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['weekday'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                                  Text(item['date'])
                                ],
                              ),
                              // Row(
                              //   children: [
                              //     Text('$tempMax$tempUnit/', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                              //     Text('$tempMin$tempUnit', style: TextStyle(fontSize: 14)),
                              //   ],
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.network(icon, height: 36),
                                  Text(type),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Divider(height: 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Image.asset('assets/temp.png', height: 20),
                                  Text("Temparature"),
                                  Text("$tempMax-$tempMin$tempUnit", style: TextStyle(fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset('assets/rain.png', height: 20),
                                  Text("Precipitation"),
                                  Text("$rf$rfUnit", style: TextStyle(fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset('assets/rh.png', height: 20),
                                  Text("Humidity"),
                                  Text("$rh$rhUnit", style: TextStyle(fontWeight: FontWeight.w700)),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset('assets/rain.png', height: 20),
                                  Text("Wind Speed"),
                                  Text("$windspd$windspdUnit", style: TextStyle(fontWeight: FontWeight.w700)),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ))
            ),

          ],
        ),
      )
    );
  }
}
