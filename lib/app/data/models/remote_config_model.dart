class RemoteConfigModel {
  RemoteConfigModel({
      String? ivEncrypt,
      String? keyEncrypt,}){
    _ivEncrypt = ivEncrypt;
    _keyEncrypt = keyEncrypt;
}

  RemoteConfigModel.fromJson(dynamic json) {
    _ivEncrypt = json['iv_encrypt'];
    _keyEncrypt = json['key_encrypt'];
  }

  String? _ivEncrypt;
  String? _keyEncrypt;

RemoteConfigModel copyWith({  String? apiAccessPassword,
  String? apiAccessUsername,
  String? ivEncrypt,
  String? keyEncrypt,
}) => RemoteConfigModel(
  ivEncrypt: ivEncrypt ?? _ivEncrypt,
  keyEncrypt: keyEncrypt ?? _keyEncrypt,
);

  String? get ivEncrypt => _ivEncrypt;
  String? get keyEncrypt => _keyEncrypt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iv_encrypt'] = _ivEncrypt;
    map['key_encrypt'] = _keyEncrypt;
    return map;
  }

}