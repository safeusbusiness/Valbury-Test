import 'package:valbury/app/data/commons/constants/firestore_path_constant.dart';
import 'package:valbury/app/data/models/hospital/hospital_model.dart';
import 'package:valbury/app/data/models/hospital/hospital_type_model.dart';
import 'package:valbury/app/data/repositorys/base_repository.dart';

class HospitalRepository extends BaseRepository {

  Future<List<HospitalModel>?> getHospitalList() async {
    var result = await firestore.collection(FirestorePathConstant.hospital).get();
    if (result.docs.isNotEmpty) {
      return result.docs.map((e) => HospitalModel.fromJson(e.data())).toList();
    } else {
      return null;
    }
  }

  Future<List<HospitalTypeModel>?> getHospitalTypeList() async {
    var result = await firestore.collection(FirestorePathConstant.hospitalType).get();
    if (result.docs.isNotEmpty) {
      return result.docs.map((e) => HospitalTypeModel.fromJson(e.data())).toList();
    } else {
      return null;
    }
  }

}