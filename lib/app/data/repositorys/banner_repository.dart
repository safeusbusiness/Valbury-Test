import 'package:valbury/app/data/commons/constants/firestore_path_constant.dart';
import 'package:valbury/app/data/models/banner_model.dart';
import 'package:valbury/app/data/repositorys/base_repository.dart';

class BannerRepository extends BaseRepository {

  Future<List<BannerModel>?> getBannerList() async {
    var result = await firestore.collection(FirestorePathConstant.banner).get();
    if (result.docs.isNotEmpty) {
      return result.docs.map((e) => BannerModel.fromJson(e.data())).toList();
    } else {
      return null;
    }
  }

}