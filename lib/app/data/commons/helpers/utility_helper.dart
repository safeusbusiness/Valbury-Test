import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get/get.dart';
import 'package:valbury/app/configs/app_data_config.dart';
import 'package:valbury/app/data/commons/helpers/dialog_utils_helper.dart';
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

  static void onStartLogout() {
    var currentSavedEmail = AppDataConfig.savedEmailRememberMe;
    AppDataConfig.clearAllData();
    AppDataConfig.savedEmailRememberMe = currentSavedEmail;
    Get.offAllNamed(Routes.login);
  }

}
