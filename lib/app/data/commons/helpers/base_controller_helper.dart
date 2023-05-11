import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:valbury/app/configs/app_data_config.dart';
import 'package:valbury/app/data/models/user/user_model.dart';

export 'package:get/get.dart';

abstract class BaseControllerHelper extends GetxController {

  final loadingStatus = false.obs;
  final refreshController = RefreshController().obs;

  UserModel? get getUserModel => AppDataConfig.userModel;

  @override
  void onInit() {
    initializeData();
    super.onInit();
  }

  void initializeData();

  void setBusy(){
    loadingStatus.value = true;
  }

  void setIdle(){
    loadingStatus.value = false;
    if (refreshController.value.isLoading || refreshController.value.isRefresh) {
      refreshController.value.loadComplete();
      refreshController.value.refreshCompleted();
    }
  }

  void setError(){
    loadingStatus.addError('error');
  }

  @override
  void onClose() {
    loadingStatus.close();
    super.onClose();
  }
}