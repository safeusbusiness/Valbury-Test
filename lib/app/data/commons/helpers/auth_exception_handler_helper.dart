import 'package:firebase_auth/firebase_auth.dart';
import 'package:valbury/app/data/commons/constants/text_constant.dart';

enum AuthResultStatusHelper {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}

class AuthExceptionHandlerHelper {
  static handleException(FirebaseAuthException e) {
    AuthResultStatusHelper status;
    switch (e.code) {
      case 'invalid-email':
      case "ERROR_INVALID_EMAIL":
        status = AuthResultStatusHelper.invalidEmail;
        break;
      case 'wrong-password':
      case "ERROR_WRONG_PASSWORD":
        status = AuthResultStatusHelper.wrongPassword;
        break;
      case 'user-not-found':
      case "ERROR_USER_NOT_FOUND":
        status = AuthResultStatusHelper.userNotFound;
        break;
      case 'user-disabled':
      case "ERROR_USER_DISABLED":
        status = AuthResultStatusHelper.userDisabled;
        break;
      case 'too-many-requests':
      case "ERROR_TOO_MANY_REQUESTS":
        status = AuthResultStatusHelper.tooManyRequests;
        break;
      case 'operation-not-allowed':
      case "ERROR_OPERATION_NOT_ALLOWED":
        status = AuthResultStatusHelper.operationNotAllowed;
        break;
      case 'email-already-in-use':
      case "ERROR_EMAIL_ALREADY_IN_USE":
        status = AuthResultStatusHelper.emailAlreadyExists;
        break;
      default:
        status = AuthResultStatusHelper.undefined;
    }
    return status;
  }

  ///
  /// Accepts AuthExceptionHandler.errorType
  ///
  static generateExceptionMessage(exceptionCode) {
    String errorMessage;
    switch (exceptionCode) {
      case AuthResultStatusHelper.invalidEmail:
        errorMessage = TextConstant.emailMalformed;
        break;
      case AuthResultStatusHelper.wrongPassword:
        errorMessage = TextConstant.wrongPassword;
        break;
      case AuthResultStatusHelper.userNotFound:
        errorMessage = TextConstant.userDoesntExists;
        break;
      case AuthResultStatusHelper.userDisabled:
        errorMessage = TextConstant.disableUser;
        break;
      case AuthResultStatusHelper.tooManyRequests:
        errorMessage = TextConstant.tooManyRequest;
        break;
      case AuthResultStatusHelper.operationNotAllowed:
        errorMessage = TextConstant.disableLoginEmail;
        break;
      case AuthResultStatusHelper.emailAlreadyExists:
        errorMessage = TextConstant.emailExists;
        break;
      default:
        errorMessage = TextConstant.loginFailed;
    }

    return errorMessage;
  }
}