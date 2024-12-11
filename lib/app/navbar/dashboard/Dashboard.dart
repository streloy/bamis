import 'package:bamis/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:bamis/app/modules/notifications/views/notifications_view.dart';
import 'package:bamis/app/navbar/dashboard/AppDrawer.dart';
import 'package:bamis/app/navbar/dashboard/DashboardController.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/ApiURL.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = Get.put(DashboardController());

  @override
  void initState() {
    controller.getSharedPrefData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Obx(()=> AppDrawer(name: controller.fullname.value, photo: controller.photo.value, time: controller.initTime.value)),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 4,
        titleSpacing: 0,
        title: Obx(() => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(controller.photo.value),
              onBackgroundImageError: ((exception, stack) {
                print(exception);
              }),
            ),
            title: Text(controller.fullname.value, style: TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text(controller.initTime.value),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors().app_primary_bg_dark,
                    child: Builder(
                      builder: (context) => IconButton(onPressed: (){ Get.to(NotificationsView(), binding: NotificationsBinding(), transition: Transition.rightToLeft); }, icon: Icon(Icons.notifications_outlined), iconSize: 20),
                    )
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors().app_primary_bg_dark,
                  child: Builder(
                    builder: (context) => IconButton(onPressed: (){ print("SAIM"); Scaffold.of(context).openDrawer(); }, icon: Icon(Icons.menu), iconSize: 20),
                  )
                ),
              ],
            )
        )),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "dashboard_today_weather".tr,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),

              // WEATHER CARD
              SizedBox(
                width: double.infinity,
                height: 225,
                child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0xFF006B05),
                            Color(0xFF003E03),
                          ]),
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // Card To
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_sharp,
                                              color: Colors.white, size: 28),
                                          Obx(() => Flexible(
                                            flex: 1,
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    controller
                                                        .currentLocationName
                                                        .value,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.w700)),
                                                Text(
                                                    controller.forecast
                                                        .value[0]
                                                    ?['weekday'] ??
                                                        '' +
                                                            ", " +
                                                            controller
                                                                .forecast
                                                                ?.value[0]
                                                            ?['date'] ??
                                                        '',
                                                    style: TextStyle(
                                                        color: Colors.white))
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Obx(() => Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${controller.forecast.value[0]['temp']['val_avg'] ?? ''}",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.amber),
                                          ),
                                          SizedBox(width: 20),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 4),
                                            child: Row(
                                              children: [
                                                Icon(Icons.arrow_upward,
                                                    size: 14,
                                                    color: Colors.white),
                                                Text(
                                                  "${controller.forecast.value[0]['temp']['val_max'] ?? ''}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(Icons.arrow_downward,
                                                    size: 14,
                                                    color: Colors.white),
                                                Text(
                                                  "${controller.forecast.value[0]['temp']['val_min'] ?? ''}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                Obx(() => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                        ApiURL.base_url_image +
                                            "assets/weather_icons/${controller.forecast.value[0]['icon']}",
                                        height: 48),
                                    SizedBox(height: 6),
                                    Text(
                                        "${controller.forecast.value[0]['type'] ?? ''}",
                                        softWrap: true,
                                        style: TextStyle(color: Colors.white))
                                  ],
                                ))
                              ],
                            ),

                            const SizedBox(height: 12),
                            Divider(
                                height: 1, thickness: 1, color: Colors.white54),
                            const SizedBox(height: 16),

                            Obx(() => Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      CupertinoIcons.cloud_heavyrain,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "dashboard_rainfall".tr,
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    Text(
                                      "${controller.forecast.value[0]['rf']['val_avg'] ?? ''} ${controller.forecast.value[0]['rf_unit'] ?? ''}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      CupertinoIcons.drop,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "dashboard_humidity".tr,
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    Text(
                                      "${controller.forecast.value[0]['rh']['val_avg'] ?? ''} ${controller.forecast.value[0]['rh_unit'] ?? ''}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      CupertinoIcons.wind,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "dashboard_wind".tr,
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                    Text(
                                      "${controller.forecast.value[0]['windspd']['val_avg']} ${controller.forecast.value[0]['windspd_unit']}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    )),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "dashboard_take_a_look".tr,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("dashboard_view_all".tr,
                        style: TextStyle(color: AppColors().app_primary)),
                  )
                ],
              ),

              Container(
                width: double.infinity,
                height: 130,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.dashboardMenu.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => {
                                Get.toNamed(
                                    controller.dashboardMenu[index]['page'])
                              },
                              child: Card(
                                color: const Color.fromRGBO(225, 255, 225, 1),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  // child: Image.network(controller.dashboardMenu[index]['image'], height: 48),
                                  child: Image.asset(
                                      'assets/module_icons/${controller.dashboardMenu[index]['image']}',
                                      height: 48, errorBuilder:
                                      (context, object, stackTrace) {
                                    return Image.asset(
                                        'assets/module_icons/ic_weather_forecast.png',
                                        height: 48);
                                  }),
                                ),
                              ),
                            ),
                            const SizedBox(height: 0),
                            Text(
                              '${controller.dashboardMenu[index]['name']}'.tr,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    }),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "dashboard_my_crops".tr,
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("dashboard_view_all".tr,
                        style: TextStyle(color: AppColors().app_primary)),
                  )
                ],
              ),

              Container(
                  height: 180,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.dashboardMenu.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 350,
                          child: Card(
                            color: const Color(0xFFFFF3BB),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      const Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Mid Altitude Paddy",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF015205)),
                                          ),
                                          Text("Bhur Kamja 1")
                                        ],
                                      ),
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        child: Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/740/740809.png",
                                            height: 60,
                                            width: 60),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  const Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          "Growth Stage: Panicle Initiation"),
                                      Text("Plantation Day: 23-10-2024"),
                                      Text(
                                          "Alert: Rice Blast (Pyricularia oryzae )")
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
