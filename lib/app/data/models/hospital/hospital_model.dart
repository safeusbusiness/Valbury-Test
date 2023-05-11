class HospitalModel {
  HospitalModel({
      String? hospitalAddress,
      String? hospitalId,
      String? hospitalPicture,
      String? hospitalTitle,
      String? hospitalType,}){
    _hospitalAddress = hospitalAddress;
    _hospitalId = hospitalId;
    _hospitalPicture = hospitalPicture;
    _hospitalTitle = hospitalTitle;
    _hospitalType = hospitalType;
}

  HospitalModel.fromJson(dynamic json) {
    _hospitalAddress = json['hospital_address'];
    _hospitalId = json['hospital_id'];
    _hospitalPicture = json['hospital_picture'];
    _hospitalTitle = json['hospital_title'];
    _hospitalType = json['hospital_type'];
  }
  String? _hospitalAddress;
  String? _hospitalId;
  String? _hospitalPicture;
  String? _hospitalTitle;
  String? _hospitalType;
HospitalModel copyWith({  String? hospitalAddress,
  String? hospitalId,
  String? hospitalPicture,
  String? hospitalTitle,
  String? hospitalType,
}) => HospitalModel(  hospitalAddress: hospitalAddress ?? _hospitalAddress,
  hospitalId: hospitalId ?? _hospitalId,
  hospitalPicture: hospitalPicture ?? _hospitalPicture,
  hospitalTitle: hospitalTitle ?? _hospitalTitle,
  hospitalType: hospitalType ?? _hospitalType,
);
  String? get hospitalAddress => _hospitalAddress;
  String? get hospitalId => _hospitalId;
  String? get hospitalPicture => _hospitalPicture;
  String? get hospitalTitle => _hospitalTitle;
  String? get hospitalType => _hospitalType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hospital_address'] = _hospitalAddress;
    map['hospital_id'] = _hospitalId;
    map['hospital_picture'] = _hospitalPicture;
    map['hospital_title'] = _hospitalTitle;
    map['hospital_type'] = _hospitalType;
    return map;
  }

}