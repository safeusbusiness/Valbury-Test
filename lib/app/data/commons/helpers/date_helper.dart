import 'package:get/get.dart';

class DateHelper {

  static int getDeviceTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static Future<int> getCurrentTimeStamp() async {
    try {
      var value = await GetConnect().get('http://worldtimeapi.org/api/ip');
      var dateTime = DateTime.tryParse(value.body['datetime']);
      return dateTime?.millisecondsSinceEpoch ?? DateHelper.getDeviceTimeStamp();
    } catch(e) {
      return DateHelper.getDeviceTimeStamp();
    }
  }

  static Future<bool> isTimeDone({required int timestamp}) async {
    int currentTimeStamp = await getCurrentTimeStamp();
    if (timestamp <= currentTimeStamp) {
      return true;
    } else {
      return false;
    }
  }

}