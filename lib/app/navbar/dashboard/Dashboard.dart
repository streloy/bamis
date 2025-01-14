import 'package:bamis/app/modules/all_module/bindings/all_module_binding.dart';
import 'package:bamis/app/modules/all_module/views/all_module_view.dart';
import 'package:bamis/app/modules/bulletins/bindings/bulletins_binding.dart';
import 'package:bamis/app/modules/bulletins/views/bulletins_view.dart';
import 'package:bamis/app/modules/crop_advisory/bindings/crop_advisory_binding.dart';
import 'package:bamis/app/modules/crop_advisory/views/crop_advisory_view.dart';
import 'package:bamis/app/modules/mycrop_add/bindings/mycrop_add_binding.dart';
import 'package:bamis/app/modules/mycrop_add/views/mycrop_add_view.dart';
import 'package:bamis/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:bamis/app/modules/notifications/views/notifications_view.dart';
import 'package:bamis/app/modules/webview/bindings/webview_binding.dart';
import 'package:bamis/app/modules/webview/views/webview_view.dart';
import 'package:bamis/app/navbar/dashboard/AppDrawer.dart';
import 'package:bamis/app/navbar/dashboard/DashboardController.dart';
import 'package:bamis/utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../utils/ApiURL.dart';
import '../../modules/crop_adviosry_stage_detail/bindings/crop_adviosry_stage_detail_binding.dart';
import '../../modules/crop_adviosry_stage_detail/views/crop_adviosry_stage_detail_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with RouteAware{
  final controller = Get.put(DashboardController());

  @override
  void initState() {
    controller.getSharedPrefData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Obx(()=> AppDrawer(name: controller.fullname.value, mobile: controller.mobile.value, photo: controller.photo.value, time: controller.initTime.value)),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 4,
        titleSpacing: 0,
        title: Obx(() => ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(controller.photo.value),
              onBackgroundImageError: ((exception, stack) { }),
            ),
            title: Text(controller.fullname.value.isEmpty ? controller.mobile.value : controller.fullname.value, style: TextStyle(fontWeight: FontWeight.w700)),
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
                      builder: (context) => IconButton(
                          onPressed: (){ Get.to(NotificationsView(), binding: NotificationsBinding(), transition: Transition.rightToLeft); },
                          icon: Obx(()=> Badge(
                            child: Icon(Icons.notifications_outlined),
                            isLabelVisible: true,
                            label: Text("${controller.notificationValue.value}"),
                          )),
                          iconSize: 20
                      ),
                    )
                  ),
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors().app_primary_bg_dark,
                  child: Builder(
                    builder: (context) => IconButton(onPressed: (){ Scaffold.of(context).openDrawer(); }, icon: Icon(Icons.menu), iconSize: 20),
                  )
                ),
              ],
            )
        )),
      ),

      body: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: SingleChildScrollView(
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
                Obx(()=> Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        Color(0xFF006B05),
                        Color(0xFF003E03),
                      ]),
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  Row(
                                    children: [
                                      Icon(Icons.location_on_sharp, color: Colors.white),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(controller.currentLocationName.value ?? "", style: TextStyle(color: Colors.white)),
                                            Text(controller.forecast.value.length > 0 ? "${controller.forecast.value[0]?['weekday']}, ${controller.forecast.value[0]?['date']}" : "", style: TextStyle(color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Image.network( controller.forecast.value.length > 0 ? ApiURL.base_url_image + "assets/weather_icons/${controller.forecast.value[0]['icon']}" : ApiURL.placeholder_auth, height: 48),
                                          // Text(controller.forecast.value.length > 0 ? "${controller.forecast.value[0]['type']}" : "", style: TextStyle(color: Colors.white)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Obx(() => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      RichText(
                                          text: TextSpan(
                                              text: controller.forecast.value.length > 0 ? "${controller.forecast.value[0]['temp']['val_avg']}${controller.forecast.value[0]['temp_unit']}" : "", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.amber)
                                          )
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              children: [
                                                WidgetSpan(child: Icon(Icons.arrow_upward, size: 14, color: Colors.white)),
                                                TextSpan(text: controller.forecast.value.length > 0 ? "${controller.forecast.value[0]['temp']['val_max']}${controller.forecast.value[0]['temp_unit']}" : "")
                                              ]
                                          )
                                      ),
                                      RichText(
                                          text: TextSpan(
                                              children: [
                                                WidgetSpan(child: Icon(Icons.arrow_downward, size: 14, color: Colors.white)),
                                                TextSpan(text: controller.forecast.value.length > 0 ? "${controller.forecast.value[0]['temp']['val_min']}${controller.forecast.value[0]['temp_unit']}" : "")
                                              ]
                                          )
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 12),
                        Divider(height: 1, thickness: 1, color: Colors.white54),
                        SizedBox(height: 16),

                        Row(
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
                                Text(controller.forecast.value.length > 0 ?
                                "${controller.forecast.value[0]['rf']['val_avg'] ?? ''} ${controller.forecast.value[0]['rf_unit'] ?? ''}" : "",
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
                                Text(controller.forecast.value.length > 0 ?
                                "${controller.forecast.value[0]['rh']['val_avg'] ?? ''} ${controller.forecast.value[0]['rh_unit'] ?? ''}" : "",
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
                                Text(controller.forecast.value.length > 0 ?
                                "${controller.forecast.value[0]['windspd']['val_avg']} ${controller.forecast.value[0]['windspd_unit']}" : "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),

                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( "dashboard_take_a_look".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                    GestureDetector(
                      onTap: () { Get.to(()=> AllModuleView(), binding: AllModuleBinding(), arguments: controller.dashboardMenu, transition: Transition.rightToLeft); },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors().app_primary)
                        ),
                        child: Text("dashboard_view_all".tr, style: TextStyle(color: AppColors().app_primary)),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 16),
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
                    GestureDetector(
                      onTap: () { Get.to(()=> CropAdvisoryView(), binding: CropAdvisoryBinding(), transition:  Transition.rightToLeft); },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors().app_primary)
                        ),
                        child: Text("dashboard_view_all".tr, style: TextStyle(color: AppColors().app_primary)),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 16),
                Obx(()=> Container(
                    height: 40,
                    child: ListView(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        GestureDetector(
                          child: Container(
                            height: double.infinity,
                            margin: EdgeInsets.only(right: 8),
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors().app_primary,
                            ),
                            child: Center(child: Text("+", style: TextStyle(fontSize: 26, color: Colors.white))),
                          ),
                          onTap: () {
                            setState(() {
                              Get.to(()=>MycropAddView(), binding: MycropAddBinding(), transition: Transition.rightToLeft);
                            });
                          },
                        ),
                        ListView.builder(
                          itemCount: controller.mycrops.value.length,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            dynamic item = controller.mycrops.value[index];
                            return GestureDetector(
                              onTap: () { controller.getMyCropStage(item); },
                              child: Container(
                                margin: EdgeInsets.only(right: 8),
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors().app_primary_bg_dark,
                                  border: Border.all(color: AppColors().app_primary, width: 1),
                                ),
                                child: Row(
                                  children: [
                                    Container( padding: EdgeInsets.symmetric(vertical: 0), child: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network("${item['image']}", height: 26, width: 26, fit: BoxFit.contain))),
                                    Container( padding: EdgeInsets.only(left: 8, right: 8), child: Text("${item['name']}", style: TextStyle(fontSize: 16)))
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        controller.mycrops.value.length < 1 ? Container(
                          margin: EdgeInsets.only(right: 8),
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors().app_primary_bg_dark,
                            border: Border.all(color: AppColors().app_primary, width: 1),
                          ),
                          child: Row(
                            children: [
                              Container( padding: EdgeInsets.only(left: 8, right: 8), child: Text("dashboard_mycrops_promo".tr, style: TextStyle(fontSize: 16)))
                            ],
                          ),
                        ) : Text("")
                      ],
                    )
                ),),

                SizedBox(height: 16),

                Obx(()=> controller.mycrops.value.length > 0 ?
                Container(
                    height: 170,
                    width: double.infinity,
                    child: ScrollablePositionedList.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.mycropsstage.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          dynamic item = controller.mycropsstage.value[index];
                          return GestureDetector(
                            onTap: () {
                              if(item['current_status'] != 'upcoming') {
                                Get.to(()=> CropAdviosryStageDetailView(), binding: CropAdviosryStageDetailBinding(), arguments: item, transition: Transition.rightToLeft);
                              } else {
                                Fluttertoast.showToast(msg: "Thsi is stage is started yet. Please wait till this stage will appear.");
                              }
                            },
                            child: Container(
                                width: 300,
                                padding: EdgeInsets.all(16),
                                margin: EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: controller.getStageCardColor(item['current_status'])
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Text(toBeginningOfSentenceCase("${item['name']}"), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: AppColors().app_primary),),
                                      subtitle: Text(toBeginningOfSentenceCase("${item['crop_name']}"), style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors().app_primary)),
                                      trailing: Container(
                                        child: Image.network("${item['image']}", height: 64, fit: BoxFit.contain,),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: Colors.white, width: 6)
                                        ),
                                      ),
                                      horizontalTitleGap: 0,
                                      minVerticalPadding: 0,
                                      minTileHeight: 0,
                                      minLeadingWidth: 0,
                                      contentPadding: EdgeInsets.all(0),
                                    ),
                                    SizedBox(height: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("dashboard_stage_status".tr + ": ${item['current_status']}", style: TextStyle(color: AppColors().app_primary)),
                                        Text("dashboard_plantation".tr + ": ${item['plantationDate']}", style: TextStyle(color: AppColors().app_primary)),
                                        Text("dashboard_stage_duration".tr + ": ${item['stage_start']} - ${item['stage_end']}", style: TextStyle(color: AppColors().app_primary)),
                                      ],
                                    )
                                  ],
                                )
                            ),
                          );
                        })
                ) : SizedBox(height: 0)
                ),

                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("dashboard_special_bulletin".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700) ),
                    GestureDetector(
                      onTap: () {
                        Get.to(()=> BulletinsView(), binding: BulletinsBinding(), transition: Transition.rightToLeft);
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors().app_primary)
                        ),
                        child: Text("dashboard_view_all".tr, style: TextStyle(color: AppColors().app_primary)),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 16),
                Obx(()=> Container(
                    height: 170,
                    width: double.infinity,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.bulletins.value.length,
                        itemBuilder: (BuildContext context, int index) {
                          dynamic item = controller.bulletins.value[index];
                          return Container(
                              width: 300,
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Color(0xFFFFEBD8)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${item['publish_date']}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
                                  Text("${item['title']}", maxLines: 3),
                                  SizedBox(height: 16),
                                  GestureDetector(
                                    onTap: (){ Get.to(()=> WebviewView(), binding: WebviewBinding(), arguments: item, transition: Transition.rightToLeft ); },
                                    child: Text("Learn more >", style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFB22222)),),
                                  )
                                ],
                              )
                          );
                        })
                )),

              ],
            ),
          )
        ),
      ),
    );
  }
}
