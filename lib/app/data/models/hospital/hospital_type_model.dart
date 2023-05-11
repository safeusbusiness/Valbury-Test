import 'package:get/get.dart';

/// hospital_type_id : ""
/// hospital_type_name : ""

class HospitalTypeModel {
  HospitalTypeModel({
      String? hospitalTypeId, 
      String? hospitalTypeName,}){
    _hospitalTypeId = hospitalTypeId;
    _hospitalTypeName = hospitalTypeName;
}

  HospitalTypeModel.fromJson(dynamic json) {
    _hospitalTypeId = json['hospital_type_id'];
    _hospitalTypeName = json['hospital_type_name'];
  }

  String? _hospitalTypeId;
  String? _hospitalTypeName;
  var isEnabled = false.obs;

HospitalTypeModel copyWith({  String? hospitalTypeId,
  String? hospitalTypeName,
}) => HospitalTypeModel(  hospitalTypeId: hospitalTypeId ?? _hospitalTypeId,
  hospitalTypeName: hospitalTypeName ?? _hospitalTypeName,
);
  String? get hospitalTypeId => _hospitalTypeId;
  String? get hospitalTypeName => _hospitalTypeName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hospital_type_id'] = _hospitalTypeId;
    map['hospital_type_name'] = _hospitalTypeName;
    return map;
  }

}