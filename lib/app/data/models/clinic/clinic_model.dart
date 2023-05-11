class ClinicModel {
  ClinicModel({
      String? clinicAddress, 
      String? clinicId, 
      String? clinicPicture, 
      String? clinicTitle, 
      String? clinicType,}){
    _clinicAddress = clinicAddress;
    _clinicId = clinicId;
    _clinicPicture = clinicPicture;
    _clinicTitle = clinicTitle;
    _clinicType = clinicType;
}

  ClinicModel.fromJson(dynamic json) {
    _clinicAddress = json['clinic_address'];
    _clinicId = json['clinic_id'];
    _clinicPicture = json['clinic_picture'];
    _clinicTitle = json['clinic_title'];
    _clinicType = json['clinic_type'];
  }
  String? _clinicAddress;
  String? _clinicId;
  String? _clinicPicture;
  String? _clinicTitle;
  String? _clinicType;
ClinicModel copyWith({  String? clinicAddress,
  String? clinicId,
  String? clinicPicture,
  String? clinicTitle,
  String? clinicType,
}) => ClinicModel(  clinicAddress: clinicAddress ?? _clinicAddress,
  clinicId: clinicId ?? _clinicId,
  clinicPicture: clinicPicture ?? _clinicPicture,
  clinicTitle: clinicTitle ?? _clinicTitle,
  clinicType: clinicType ?? _clinicType,
);
  String? get clinicAddress => _clinicAddress;
  String? get clinicId => _clinicId;
  String? get clinicPicture => _clinicPicture;
  String? get clinicTitle => _clinicTitle;
  String? get clinicType => _clinicType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clinic_address'] = _clinicAddress;
    map['clinic_id'] = _clinicId;
    map['clinic_picture'] = _clinicPicture;
    map['clinic_title'] = _clinicTitle;
    map['clinic_type'] = _clinicType;
    return map;
  }

}