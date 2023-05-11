import 'package:valbury/app/data/commons/constants/firestore_path_constant.dart';
import 'package:valbury/app/data/models/clinic/clinic_model.dart';
import 'package:valbury/app/data/models/clinic/clinic_type_model.dart';
import 'package:valbury/app/data/repositorys/base_repository.dart';

class ClinicRepository extends BaseRepository {

  Future<List<ClinicModel>?> getClinicList() async {
    var result = await firestore.collection(FirestorePathConstant.clinic).get();
    if (result.docs.isNotEmpty) {
      return result.docs.map((e) => ClinicModel.fromJson(e.data())).toList();
    } else {
      return null;
    }
  }

  Future<List<ClinicTypeModel>?> getClinicTypeList() async {
    var result = await firestore.collection(FirestorePathConstant.clinicType).get();
    if (result.docs.isNotEmpty) {
      return result.docs.map((e) => ClinicTypeModel.fromJson(e.data())).toList();
    } else {
      return null;
    }
  }

}