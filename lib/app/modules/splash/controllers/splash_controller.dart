import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valbury/app/configs/app_data_config.dart';
import 'package:valbury/app/data/commons/helpers/base_controller_helper.dart';
import 'package:valbury/app/data/commons/helpers/date_helper.dart';
import 'package:valbury/app/data/commons/helpers/log_helper.dart';
import 'package:valbury/app/data/commons/helpers/utility_helper.dart';
import 'package:valbury/app/data/services/local_storage_service.dart';
import 'package:valbury/app/data/services/remote_config_service.dart';
import 'package:valbury/app/routes/app_pages.dart';

class SplashController extends BaseControllerHelper {

  @override
  void initializeData() async {
    await initializeApp();

    if (AppDataConfig.userModel != null) {
      var timestamp = AppDataConfig.timeStampReLogin;
      if (await DateHelper.isTimeDone(timestamp: timestamp)) {
        UtilityHelper.onStartLogout();
        AppDataConfig.timeStampReLogin = 0;
      } else {
        Get.offAllNamed(Routes.init);
        return;
      }
    }

    Get.offAllNamed(Routes.login);
  }

  Future<void> initializeApp() async {
    LogHelper.print('Initializing Firebase Started...');
    await Firebase.initializeApp();

    LogHelper.print('Initializing Remote Config Started...');
    await RemoteConfigService().initializeData();

    LogHelper.print('Initializing Local Storage Started...');
    LocalStorageService.prefs = await SharedPreferences.getInstance();

    await Future.delayed(const Duration(seconds: 1));
  }

}
