import 'dart:convert';
import 'package:valbury/app/data/commons/constants/app_data_constant.dart';
import 'package:valbury/app/data/models/user/user_model.dart';
import 'package:valbury/app/data/services/local_storage_service.dart';

class AppDataConfig {

  static set maximumForgotPasswordTimes(int? value) =>
      LocalStorageService.saveToDisk(AppDataConstant.maximumForgotPasswordTimesKey, value);

  static int get maximumForgotPasswordTimes {
    if (LocalStorageService.getFromDisk(AppDataConstant.maximumForgotPasswordTimesKey) != null) {
      return LocalStorageService.getFromDisk(AppDataConstant.maximumForgotPasswordTimesKey);
    }
    return 0;
  }

  static set timeStampReLogin(int value) =>
      LocalStorageService.saveToDisk(AppDataConstant.timeStampReLoginKey, value);

  static int get timeStampReLogin {
    if (LocalStorageService.getFromDisk(AppDataConstant.timeStampReLoginKey) != null) {
      return LocalStorageService.getFromDisk(AppDataConstant.timeStampReLoginKey);
    }
    return 0;
  }

  static set failedLoginMultipleTimes(int? value) =>
      LocalStorageService.saveToDisk(AppDataConstant.failedLoginMultipleTimesKey, value);

  static int? get failedLoginMultipleTimes {
    if (LocalStorageService.getFromDisk(AppDataConstant.failedLoginMultipleTimesKey) != null) {
      return LocalStorageService.getFromDisk(AppDataConstant.failedLoginMultipleTimesKey);
    }
    return null;
  }

  static set savedEmailRememberMe(String? value) =>
      LocalStorageService.saveToDisk(AppDataConstant.savedEmailRememberMeKey, value);

  static String? get savedEmailRememberMe {
    if (LocalStorageService.getFromDisk(AppDataConstant.savedEmailRememberMeKey) != null) {
      return LocalStorageService.getFromDisk(AppDataConstant.savedEmailRememberMeKey);
    }
    return null;
  }

  static UserModel? get userModel {
    var value = LocalStorageService.getFromDisk(AppDataConstant.userModelDataKey, decrypt: true);
    if (value != null) {
      return UserModel.fromJson(jsonDecode(value));
    }
    return null;
  }

  static set userModel(UserModel? value) {
    if (value != null) {
      LocalStorageService.saveToDisk(
          AppDataConstant.userModelDataKey, jsonEncode(value.toJson()),
          encrypt: true
      );
    }
  }

  static void clearAllData() {
    LocalStorageService.removeFromDisk(null, clearAll: true);
  }

}
