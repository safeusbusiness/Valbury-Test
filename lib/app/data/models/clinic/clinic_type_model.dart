import 'package:get/get.dart';

/// clinic_type_id : ""
/// clinic_type_name : ""

class ClinicTypeModel {
  ClinicTypeModel({
      String? clinicTypeId, 
      String? clinicTypeName,}){
    _clinicTypeId = clinicTypeId;
    _clinicTypeName = clinicTypeName;
}

  ClinicTypeModel.fromJson(dynamic json) {
    _clinicTypeId = json['clinic_type_id'];
    _clinicTypeName = json['clinic_type_name'];
  }
  String? _clinicTypeId;
  String? _clinicTypeName;
  var isEnabled = false.obs;

ClinicTypeModel copyWith({  String? clinicTypeId,
  String? clinicTypeName,
}) => ClinicTypeModel(  clinicTypeId: clinicTypeId ?? _clinicTypeId,
  clinicTypeName: clinicTypeName ?? _clinicTypeName,
);
  String? get clinicTypeId => _clinicTypeId;
  String? get clinicTypeName => _clinicTypeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['clinic_type_id'] = _clinicTypeId;
    map['clinic_type_name'] = _clinicTypeName;
    return map;
  }

}