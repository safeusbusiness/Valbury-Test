import 'package:get_it/get_it.dart';
import 'package:valbury/app/data/models/remote_config_model.dart';

class AppEnvConfig {

  static String secretKeyIv({required bool isGetKey}) {
    var remoteConfigModel = GetIt.I<RemoteConfigModel>();
    if (isGetKey) {
      return remoteConfigModel.keyEncrypt ?? '';
    } else {
      return remoteConfigModel.ivEncrypt ?? '';
    }
  }
}
