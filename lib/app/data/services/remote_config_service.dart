import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get_it/get_it.dart';
import 'package:valbury/app/data/commons/constants/remote_config_constant.dart';
import 'package:valbury/app/data/commons/helpers/log_helper.dart';
import 'package:valbury/app/data/models/remote_config_model.dart';

class RemoteConfigService {

  Future<void> initializeData() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await remoteConfig.fetchAndActivate();
    var keyValue = remoteConfig.getString(RemoteConfigConstant.keyEncrypt);
    var ivValue = remoteConfig.getString(RemoteConfigConstant.ivEncrypt);
    LogHelper.print(
        'Remote Config Result:\n'
            'Key: $keyValue\n'
            'Iv: $ivValue\n'
            'All: ${remoteConfig.getAll().toString()}'
    );
    GetIt.I.registerSingleton<RemoteConfigModel>(RemoteConfigModel(
        keyEncrypt: keyValue,
        ivEncrypt: ivValue
    ));
  }

}