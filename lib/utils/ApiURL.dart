
class ApiURL {
  static String base_url = "https://bamisapp.bdservers.site/";
  static String base_url_api = "https://bamisapp.bdservers.site/api/";
  static String base_url_image = "https://bamisapp.bdservers.site/";

  static Uri login = Uri.parse('${base_url_api}auth/login');
  static Uri mobile = Uri.parse('${base_url_api}auth/mobile');
  static Uri otpcheck = Uri.parse('${base_url_api}auth/otpcheck');

  // Weather
  static Uri locations = Uri.parse('${base_url_api}weather/locations');
  static String dailyforecast = '${base_url_api}weather/dailyforecast';
  static String currentforecast = '${base_url_api}weather/currentforecast';
  static String location_latlon = '${base_url_api}weather/location_latlon';

  // Weather Alert
  static String webview_url = '${base_url}webview/weather_alert';

  // Flood Forecast
  static String flood_forecast_url = '${base_url}webview/flood_forecast';

  // FCM
  static Uri fcm = Uri.parse('${base_url_api}auth/fcm');

  // AGRI HUB
  static Uri agrihub_crop_type = Uri.parse('${base_url_api}agrihub/croptype');
  static String agrihub_crop_name = "${base_url_api}agrihub/cropname?type=";
  static String agrihub_crop_variety = "${base_url_api}agrihub/cropvariety?name=";
  static String agrihub_webview = "${base_url}webview/agrihub_crop?crop_variety_id=";

  // Elibrary
  static Uri elibrary_books = Uri.parse('${base_url_api}elibrary/books');
  static Uri elibrary_tags = Uri.parse('${base_url_api}elibrary/tags');

  // Profile
  static Uri profile = Uri.parse('${base_url_api}profile');

  // Community
  static String community_post = '${base_url_api}community/post';
  static String community_reaction = '${base_url_api}community/reaction';
  static String community_postdetail = '${base_url_api}community/postdetail';
  static String community_postcomments = '${base_url_api}community/postcomments';
  static String community_postcommentsubmit = '${base_url_api}community/submitpostcomments';
  static String community_postadd = '${base_url_api}community/addpost';
  static String community_mypost = '${base_url_api}community/mypost';

  // Bulletin
  static String bulltin_location = '${base_url_api}bulletin/location';
  static String bulltin_category = '${base_url_api}bulletin/category';
  static String bulltin_list = '${base_url_api}bulletin/list';
  static String bulltin_dashboard = '${base_url_api}bulletin/dashboard';

  // Important Video
  static String important_video_list = '${base_url_api}Importantvideo/videos';

  // Pest & Disease Detection Using Camera
  static String analysis_croplist = '${base_url_api}analysis/croplist';
  static String analysis_image = '${base_url_api}analysis/image';

  // Pest & Disease Alert
  static String disease_crops = '${base_url_api}disease/crops';
  static String disease_stages = '${base_url_api}disease/stages';
  static String disease_diseases = '${base_url_api}disease/diseases';

  // Notifications
  static String notification_notifications = '${base_url_api}notification/notifications';
  static String notification_updateseen = '${base_url_api}notification/updateseen';

  // Mycrops
  static String mycrops_croplist = '${base_url_api}mycrop/croplist';
  static String mycrops_crops = '${base_url_api}mycrop/crops';
  static String mycrops_locations = '${base_url_api}mycrop/locations';
  static String mycrops_mycropstage = '${base_url_api}mycrop/mycropstage';
  static String mycrops_mycropstagedetail_advisory = '${base_url_api}mycrop/my_crop_stage_detail_advisory';
  static String mycrops_mycropstagedetail_disease = '${base_url_api}mycrop/my_crop_stage_detail_disease';
  static String mycrops_taskreminder = '${base_url_api}mycrop/taskreminder';

  // Sidebar
  static String sidebar_contact_us = '${base_url}sidebar/contact_us';
  static String sidebar_faq = '${base_url}sidebar/faq';

  //
  static String placeholder_auth = "https://bamisapp.bdservers.site/assets/auth/profile.jpg";
  static String placeholder_community_cover = "https://bamisapp.bdservers.site/assets/community/default.png";

}