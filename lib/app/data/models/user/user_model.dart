import 'package:valbury/app/data/services/encrypt_decrypt_service.dart';

class UserModel {
  UserModel({
      String? userPhone, 
      String? userEmail, 
      String? userFirstName, 
      String? userLastName,
      this.userId,
      String? userPassword,
  }){
    _userPhone = userPhone;
    _userEmail = userEmail;
    _userFirstName = userFirstName;
    _userLastName = userLastName;
    _userPassword = userPassword;
}

  UserModel.fromJson(dynamic json) {
    _userPhone = EncryptDecryptService.start(content: json['user_phone'], isEncrypt: false);
    _userEmail = EncryptDecryptService.start(content: json['user_email'], isEncrypt: false);
    _userFirstName = EncryptDecryptService.start(content: json['user_first_name'], isEncrypt: false);
    _userLastName = EncryptDecryptService.start(content: json['user_last_name'], isEncrypt: false);
    userId = json['user_id'];
    _userPassword = EncryptDecryptService.start(content: json['user_password'], isEncrypt: false);
  }
  String? _userPhone;
  String? _userEmail;
  String? _userFirstName;
  String? _userLastName;
  String? userId;
  String? _userPassword;

  UserModel copyWith({  String? userPhone,
  String? userEmail,
  String? userFirstName,
  String? userLastName,
  String? userId,
  String? userPassword,
}) => UserModel(  userPhone: userPhone ?? _userPhone,
  userEmail: userEmail ?? _userEmail,
  userFirstName: userFirstName ?? _userFirstName,
  userLastName: userLastName ?? _userLastName,
  userId: userId ?? this.userId,
  userPassword: userPassword ?? _userPassword
);
  String? get userPhone => _userPhone;
  String? get userEmail => _userEmail;
  String? get userFirstName => _userFirstName;
  String? get userLastName => _userLastName;
  String? get userPassword => _userPassword;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_phone'] = EncryptDecryptService.start(content: _userPhone);
    map['user_email'] = EncryptDecryptService.start(content: _userEmail);
    map['user_first_name'] = EncryptDecryptService.start(content: _userFirstName);
    map['user_last_name'] = EncryptDecryptService.start(content: _userLastName);
    map['user_id'] = userId;
    map['user_password'] = EncryptDecryptService.start(content: _userPassword);
    return map;
  }

}