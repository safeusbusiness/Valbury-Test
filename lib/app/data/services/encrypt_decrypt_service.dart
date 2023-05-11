import 'package:encrypt/encrypt.dart';
import 'package:valbury/app/configs/app_env_config.dart';
import 'package:valbury/app/data/commons/constants/global_constant.dart';
import 'package:valbury/app/data/commons/helpers/log_helper.dart';

class EncryptDecryptService {

  static String start({
    required String? content,
    bool isEncrypt = true
  }) {
    if (content?.isNotEmpty ?? false || content == GlobalConstant.nullConstant) {
      final keyVal = AppEnvConfig.secretKeyIv(isGetKey: true);
      final ivVal = AppEnvConfig.secretKeyIv(isGetKey: true);
      if (keyVal.isNotEmpty && ivVal.isNotEmpty) {
        final key = Key.fromUtf8(keyVal);
        final iv = IV.fromUtf8(ivVal);
        final tools = Encrypter(AES(key, mode: AESMode.cbc));
        RegExp regExp = RegExp(r'^(?:[A-Za-z0-9+\/]{4})*(?:[A-Za-z0-9+\/]{2}==|[A-Za-z0-9+\/]{3}=|[A-Za-z0-9+\/]{4})$');
        if (isEncrypt) {
          var contentEncrypted = tools.encrypt(content!, iv: iv);
          return contentEncrypted.base64;
        } else {
          try {
            var contentDecrypted = tools.decrypt64(content!, iv: iv);
            if (regExp.hasMatch(content)) {
              return contentDecrypted;
            } else {
              return content;
            }
          } catch (e) {
            LogHelper.error(e, event: 'EncryptDecryptService');
          }
        }
      }
    }
    return content!;
  }
}
