import 'package:get/get.dart';

import '../modules/all_module/bindings/all_module_binding.dart';
import '../modules/all_module/views/all_module_view.dart';
import '../modules/articles/bindings/articles_binding.dart';
import '../modules/articles/views/articles_view.dart';
import '../modules/bamis_portal/bindings/bamis_portal_binding.dart';
import '../modules/bamis_portal/views/bamis_portal_view.dart';
import '../modules/bulletin_district/bindings/bulletin_district_binding.dart';
import '../modules/bulletin_district/views/bulletin_district_view.dart';
import '../modules/bulletin_national/bindings/bulletin_national_binding.dart';
import '../modules/bulletin_national/views/bulletin_national_view.dart';
import '../modules/bulletin_special/bindings/bulletin_special_binding.dart';
import '../modules/bulletin_special/views/bulletin_special_view.dart';
import '../modules/bulletins/bindings/bulletins_binding.dart';
import '../modules/bulletins/views/bulletins_view.dart';
import '../modules/community_post_add/bindings/community_post_add_binding.dart';
import '../modules/community_post_add/views/community_post_add_view.dart';
import '../modules/community_post_detail/bindings/community_post_detail_binding.dart';
import '../modules/community_post_detail/views/community_post_detail_view.dart';
import '../modules/community_post_my/bindings/community_post_my_binding.dart';
import '../modules/community_post_my/views/community_post_my_view.dart';
import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/crop_adviosry_stage_detail/bindings/crop_adviosry_stage_detail_binding.dart';
import '../modules/crop_adviosry_stage_detail/views/crop_adviosry_stage_detail_view.dart';
import '../modules/crop_adviosry_stages/bindings/crop_adviosry_stages_binding.dart';
import '../modules/crop_adviosry_stages/views/crop_adviosry_stages_view.dart';
import '../modules/crop_advisory/bindings/crop_advisory_binding.dart';
import '../modules/crop_advisory/views/crop_advisory_view.dart';
import '../modules/crop_disease/bindings/crop_disease_binding.dart';
import '../modules/crop_disease/views/crop_disease_view.dart';
import '../modules/crop_disease_stages/bindings/crop_disease_stages_binding.dart';
import '../modules/crop_disease_stages/views/crop_disease_stages_view.dart';
import '../modules/crop_disease_stages_detail/bindings/crop_disease_stages_detail_binding.dart';
import '../modules/crop_disease_stages_detail/views/crop_disease_stages_detail_view.dart';
import '../modules/elibrary/bindings/elibrary_binding.dart';
import '../modules/elibrary/views/elibrary_view.dart';
import '../modules/faq/bindings/faq_binding.dart';
import '../modules/faq/views/faq_view.dart';
import '../modules/farm_metrics/bindings/farm_metrics_binding.dart';
import '../modules/farm_metrics/views/farm_metrics_view.dart';
import '../modules/flood_forecast/bindings/flood_forecast_binding.dart';
import '../modules/flood_forecast/views/flood_forecast_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/important_video/bindings/important_video_binding.dart';
import '../modules/important_video/views/important_video_view.dart';
import '../modules/mycrop/bindings/mycrop_binding.dart';
import '../modules/mycrop/views/mycrop_view.dart';
import '../modules/mycrop_add/bindings/mycrop_add_binding.dart';
import '../modules/mycrop_add/views/mycrop_add_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/pdfview/bindings/pdfview_binding.dart';
import '../modules/pdfview/views/pdfview_view.dart';
import '../modules/pest_disease_alert_detail/bindings/pest_disease_alert_detail_binding.dart';
import '../modules/pest_disease_alert_detail/views/pest_disease_alert_detail_view.dart';
import '../modules/pest_disease_alerts/bindings/pest_disease_alerts_binding.dart';
import '../modules/pest_disease_alerts/views/pest_disease_alerts_view.dart';
import '../modules/scan_detail/bindings/scan_detail_binding.dart';
import '../modules/scan_detail/views/scan_detail_view.dart';
import '../modules/task_reminder/bindings/task_reminder_binding.dart';
import '../modules/task_reminder/views/task_reminder_view.dart';
import '../modules/task_reminder_detail/bindings/task_reminder_detail_binding.dart';
import '../modules/task_reminder_detail/views/task_reminder_detail_view.dart';
import '../modules/weather_alert/bindings/weather_alert_binding.dart';
import '../modules/weather_alert/views/weather_alert_view.dart';
import '../modules/weather_forecast/bindings/weather_forecast_binding.dart';
import '../modules/weather_forecast/views/weather_forecast_view.dart';
import '../modules/webview/bindings/webview_binding.dart';
import '../modules/webview/views/webview_view.dart';
import '../modules/ytplayer/bindings/ytplayer_binding.dart';
import '../modules/ytplayer/views/ytplayer_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.WEATHER_FORECAST,
      page: () => const WeatherForecastView(),
      binding: WeatherForecastBinding(),
    ),
    GetPage(
      name: _Paths.WEATHER_ALERT,
      page: () => const WeatherAlertView(),
      binding: WeatherAlertBinding(),
    ),
    GetPage(
      name: _Paths.FLOOD_FORECAST,
      page: () => const FloodForecastView(),
      binding: FloodForecastBinding(),
    ),
    GetPage(
      name: _Paths.WEBVIEW,
      page: () => const WebviewView(),
      binding: WebviewBinding(),
    ),
    GetPage(
      name: _Paths.ELIBRARY,
      page: () => const ElibraryView(),
      binding: ElibraryBinding(),
    ),
    GetPage(
      name: _Paths.PDFVIEW,
      page: () => const PdfviewView(),
      binding: PdfviewBinding(),
    ),
    GetPage(
      name: _Paths.BULLETINS,
      page: () => const BulletinsView(),
      binding: BulletinsBinding(),
    ),
    GetPage(
      name: _Paths.CROP_ADVISORY,
      page: () => const CropAdvisoryView(),
      binding: CropAdvisoryBinding(),
    ),
    GetPage(
      name: _Paths.PEST_DISEASE_ALERTS,
      page: () => const PestDiseaseAlertsView(),
      binding: PestDiseaseAlertsBinding(),
    ),
    GetPage(
      name: _Paths.FARM_METRICS,
      page: () => const FarmMetricsView(),
      binding: FarmMetricsBinding(),
    ),
    GetPage(
      name: _Paths.TASK_REMINDER,
      page: () => const TaskReminderView(),
      binding: TaskReminderBinding(),
    ),
    GetPage(
      name: _Paths.COMMUNITY_POST_DETAIL,
      page: () => const CommunityPostDetailView(),
      binding: CommunityPostDetailBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.BULLETIN_NATIONAL,
      page: () => const BulletinNationalView(),
      binding: BulletinNationalBinding(),
    ),
    GetPage(
      name: _Paths.BULLETIN_DISTRICT,
      page: () => const BulletinDistrictView(),
      binding: BulletinDistrictBinding(),
    ),
    GetPage(
      name: _Paths.BULLETIN_SPECIAL,
      page: () => const BulletinSpecialView(),
      binding: BulletinSpecialBinding(),
    ),
    GetPage(
      name: _Paths.IMPORTANT_VIDEO,
      page: () => const ImportantVideoView(),
      binding: ImportantVideoBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => const ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLES,
      page: () => const ArticlesView(),
      binding: ArticlesBinding(),
    ),
    GetPage(
      name: _Paths.YTPLAYER,
      page: () => const YtplayerView(),
      binding: YtplayerBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_DETAIL,
      page: () => const ScanDetailView(),
      binding: ScanDetailBinding(),
    ),
    GetPage(
      name: _Paths.PEST_DISEASE_ALERT_DETAIL,
      page: () => const PestDiseaseAlertDetailView(),
      binding: PestDiseaseAlertDetailBinding(),
    ),
    GetPage(
      name: _Paths.MYCROP,
      page: () => const MycropView(),
      binding: MycropBinding(),
    ),
    GetPage(
      name: _Paths.MYCROP_ADD,
      page: () => const MycropAddView(),
      binding: MycropAddBinding(),
    ),
    GetPage(
      name: _Paths.CROP_ADVIOSRY_STAGES,
      page: () => const CropAdviosryStagesView(),
      binding: CropAdviosryStagesBinding(),
    ),
    GetPage(
      name: _Paths.CROP_ADVIOSRY_STAGE_DETAIL,
      page: () => const CropAdviosryStageDetailView(),
      binding: CropAdviosryStageDetailBinding(),
    ),
    GetPage(
      name: _Paths.CROP_DISEASE,
      page: () => const CropDiseaseView(),
      binding: CropDiseaseBinding(),
    ),
    GetPage(
      name: _Paths.CROP_DISEASE_STAGES,
      page: () => const CropDiseaseStagesView(),
      binding: CropDiseaseStagesBinding(),
    ),
    GetPage(
      name: _Paths.CROP_DISEASE_STAGES_DETAIL,
      page: () => const CropDiseaseStagesDetailView(),
      binding: CropDiseaseStagesDetailBinding(),
    ),
    GetPage(
      name: _Paths.ALL_MODULE,
      page: () => const AllModuleView(),
      binding: AllModuleBinding(),
    ),
    GetPage(
      name: _Paths.COMMUNITY_POST_ADD,
      page: () => CommunityPostAddView(),
      binding: CommunityPostAddBinding(),
    ),
    GetPage(
      name: _Paths.COMMUNITY_POST_MY,
      page: () => const CommunityPostMyView(),
      binding: CommunityPostMyBinding(),
    ),
    GetPage(
      name: _Paths.TASK_REMINDER_DETAIL,
      page: () => const TaskReminderDetailView(),
      binding: TaskReminderDetailBinding(),
    ),
    GetPage(
      name: _Paths.BAMIS_PORTAL,
      page: () => const BamisPortalView(),
      binding: BamisPortalBinding(),
    ),
  ];
}
