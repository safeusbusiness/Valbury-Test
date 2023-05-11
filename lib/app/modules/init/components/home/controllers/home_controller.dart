import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:valbury/app/data/commons/helpers/base_controller_helper.dart';
import 'package:valbury/app/data/models/banner_model.dart';
import 'package:valbury/app/data/models/clinic/clinic_model.dart';
import 'package:valbury/app/data/models/clinic/clinic_type_model.dart';
import 'package:valbury/app/data/models/hospital/hospital_model.dart';
import 'package:valbury/app/data/models/hospital/hospital_type_model.dart';
import 'package:valbury/app/data/repositorys/banner_repository.dart';
import 'package:valbury/app/data/repositorys/clinic_repository.dart';
import 'package:valbury/app/data/repositorys/hospital_repository.dart';

class HomeController extends BaseControllerHelper {

  final hospitalRepo = HospitalRepository();
  final clinicRepo = ClinicRepository();
  final bannerRepo = BannerRepository();

  var hospitalList = <HospitalModel>[].obs;
  var hospitalTypeList = <HospitalTypeModel>[].obs;

  var clinicList = <ClinicModel>[].obs;
  var clinicTypeList = <ClinicTypeModel>[].obs;

  var bannerList = <BannerModel>[].obs;

  double get defaultListHeight => 33.5.h;

  void onTabChanged(int p1) {

  }

  @override
  void initializeData() async {
    setBusy();
    await onGetHospitalData();
    await onGetClinicData();
    await onGetBannerData();
    setIdle();
  }

  Future<void> onGetHospitalData() async {
    var value1 = await hospitalRepo.getHospitalList();
    if (value1?.isNotEmpty ?? false) {
      hospitalList.value = value1!;
    }
    var value2 = await hospitalRepo.getHospitalTypeList();
    if (value2?.isNotEmpty ?? false) {
      value2!.map((e){
        if (e.hospitalTypeId == '1') {
          e.isEnabled.value = true;
        }
      }).toList();
      hospitalTypeList.value = value2;
    }
  }

  Future<void> onGetClinicData() async {
    var value1 = await clinicRepo.getClinicList();
    if (value1?.isNotEmpty ?? false) {
      clinicList.value = value1!;
    }
    var value2 = await clinicRepo.getClinicTypeList();
    if (value2?.isNotEmpty ?? false) {
      value2!.map((e){
        if (e.clinicTypeId == '1') {
          e.isEnabled.value = true;
        }
      }).toList();
      clinicTypeList.value = value2;
    }
  }

  Future<void> onGetBannerData() async {
    var value = await bannerRepo.getBannerList();
    if (value?.isNotEmpty ?? false) {
      bannerList.value = value!;
    }
  }

  void onHospitalTypeClicked(int index) {
    var model = hospitalTypeList[index];
    hospitalTypeList.map((element) => element.isEnabled.value = false).toList();
    model.isEnabled.value = true;
    hospitalTypeList.refresh();
  }

  List<HospitalModel> getHospitalList() {
    var getTypeId = hospitalTypeList.firstWhereOrNull((element) => element.isEnabled.value);
    List<HospitalModel> copiedList = List.from(hospitalList);
    if (getTypeId?.hospitalTypeId != '1') {
      return copiedList.where((element) => element.hospitalType == (getTypeId?.hospitalTypeId ?? '1')).toList();
    }
    return copiedList;
  }

  void onClinicTypeClicked(int index) {
    var model = clinicTypeList[index];
    clinicTypeList.map((element) => element.isEnabled.value = false).toList();
    model.isEnabled.value = true;
    clinicTypeList.refresh();
  }

  List<ClinicModel> getClinicList() {
    var getTypeId = clinicTypeList.firstWhereOrNull((element) => element.isEnabled.value);
    List<ClinicModel> copiedList = List.from(clinicList);
    if (getTypeId?.clinicTypeId != '1') {
      return copiedList.where((element) => element.clinicType == (getTypeId?.clinicTypeId ?? '1')).toList();
    }
    return copiedList;
  }

}
