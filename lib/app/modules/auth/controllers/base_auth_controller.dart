import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:valbury/app/data/commons/helpers/auth_exception_handler_helper.dart';
import 'package:valbury/app/data/commons/helpers/base_controller_helper.dart';
import 'package:valbury/app/data/commons/widgets/global_widget.dart';
import 'package:valbury/app/data/repositorys/user_repository.dart';
import 'package:valbury/app/routes/app_pages.dart';

abstract class BaseAuthController extends BaseControllerHelper {

  final userRepo = UserRepository();

  var emailController = TextEditingController().obs;
  var emailError = ''.obs;
  var passwordController = TextEditingController().obs;
  var passwordError = ''.obs;

  bool isButtonDisable();

  void resetAllData();

  Future<void> submit();

  String textButtonLogic();

  void onFailedAuth(FirebaseAuthException e) => GlobalWidget.showSnackBar(
      message: AuthExceptionHandlerHelper.generateExceptionMessage(
          AuthExceptionHandlerHelper.handleException(e).toString()
      )
  );

  void onNavigateHome() {
    Get.offAllNamed(Routes.init);
  }

}