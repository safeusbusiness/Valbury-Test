import 'package:firebase_auth/firebase_auth.dart';
import 'package:valbury/app/data/commons/constants/firestore_path_constant.dart';
import 'package:valbury/app/data/models/user/user_model.dart';
import 'package:valbury/app/data/repositorys/base_repository.dart';
import 'package:valbury/app/data/services/encrypt_decrypt_service.dart';

class UserRepository extends BaseRepository {
  Future<UserModel?> createUpdateProfile(
      {required UserModel userModel, bool isSkipUpdate = false}) async {
    try {
      var val = firestore
          .collection(FirestorePathConstant.users)
          .doc(userModel.userId);
      var checkDataResponse = await val.get();
      if (checkDataResponse.exists) {
        if (!isSkipUpdate) await val.update(userModel.toJson());
      } else {
        await val.set(userModel.toJson());
      }
      return userModel;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUserByEmail({required String email}) async {
    try {
      var val = await firestore
          .collection(FirestorePathConstant.users)
          .where('user_email',
              isEqualTo: EncryptDecryptService.start(content: email))
          .get();
      if (val.docs.isNotEmpty) {
        return UserModel.fromJson(val.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUserByPhone({required String phone}) async {
    try {
      var val = await firestore
          .collection(FirestorePathConstant.users)
          .where('user_phone',
              isEqualTo: EncryptDecryptService.start(content: phone))
          .get();
      if (val.docs.isNotEmpty) {
        return UserModel.fromJson(val.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUserInformation() async {
    try {
      var val = await firestore
          .collection(FirestorePathConstant.users)
          .doc(fAuth.currentUser!.uid)
          .get();
      if (val.exists) {
        return UserModel.fromJson(val.data()!);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> loginRegisterAccount(
      {bool isLogin = true,
      required UserModel? userModel,
      required Function(FirebaseAuthException) onError}) async {
    void onFailedLogin() async {
      if (fAuth.currentUser != null) {
        await fAuth.signOut();
      }
    }

    void onCreateUpdateAccount() async {
      var response =
          await createUpdateProfile(userModel: userModel!, isSkipUpdate: true);
      if (response == null) onFailedLogin();
    }

    try {
      UserCredential credentials = isLogin
          ? await fAuth.signInWithEmailAndPassword(
              email: userModel!.userEmail!, password: userModel.userPassword!)
          : await fAuth.createUserWithEmailAndPassword(
              email: userModel!.userEmail!, password: userModel.userPassword!);
      if (credentials.user != null) {
        var value = await getUserInformation();
        if (value != null) {
          userModel = value;
        }
        userModel.userId = credentials.user!.uid;
        if (!isLogin) {
          onCreateUpdateAccount();
        }
      } else {
        onFailedLogin();
      }
    } on FirebaseAuthException catch (e) {
      userModel = null;
      onError(e);
    }

    return userModel;
  }
}
