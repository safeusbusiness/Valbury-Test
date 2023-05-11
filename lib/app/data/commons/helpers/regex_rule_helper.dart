import 'package:valbury/app/data/commons/constants/text_constant.dart';

class RegexRuleHelper {
  static RegexValidationHelper emailValidationRule = RegexValidationHelper(
      regex: r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      errorMesssage: TextConstant.errorTextEmail
  );
  static RegexValidationHelper maximum10CharRule = RegexValidationHelper(
      regex: r'^.{10,}$',
      errorMesssage: TextConstant.maximum10Char
  );
  static RegexValidationHelper phoneNumberValidationRule = RegexValidationHelper(
      regex: r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$',
      errorMesssage: TextConstant.errorTextPhoneNumber
  );
  static RegexValidationHelper alphabetValidationRule = RegexValidationHelper(
    regex: r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
    errorMesssage: TextConstant.alphabetOnly,
  );
}

class RegexValidationHelper {
  final String regex;
  final String? errorMesssage;

  RegexValidationHelper({required this.regex, this.errorMesssage});
}
