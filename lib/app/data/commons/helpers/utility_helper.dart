import 'package:get/get.dart';
import 'package:valbury/app/configs/app_data_config.dart';
import 'package:valbury/app/routes/app_pages.dart';

class UtilityHelper {

  static bool isTextIsUrl(String text) {
    return Uri.tryParse(text)?.hasAbsolutePath ?? false;
  }

  static bool isTextFieldNotValid({required String errorText, required String text}) {
    bool isNotValid = false;
    if (errorText.isNotEmpty) {
      isNotValid = true;
    } else {
      if (text.isEmpty) {
        isNotValid = true;
      }
    }
    return isNotValid;
  }

  static Future<void> onStartLogout({Function()? showLoadingProgress, Function()? hideLoadingProgress}) async {
    var currentSavedEmail = AppDataConfig.savedEmailRememberMe;
    AppDataConfig.clearAllData();
    AppDataConfig.savedEmailRememberMe = currentSavedEmail;
    if (showLoadingProgress != null) {
      showLoadingProgress();
      await Future.delayed(const Duration(seconds: 3));
    }
    if (hideLoadingProgress != null) hideLoadingProgress();
    Get.offAllNamed(Routes.login);
  }

}
