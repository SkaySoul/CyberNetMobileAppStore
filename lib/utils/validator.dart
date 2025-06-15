

import 'package:get/get_utils/src/get_utils/get_utils.dart';

class Validator{

Validator();

String? validateNonEmpty(String? val) => (val?.isEmpty ?? true) ? 'Required field' : null;

String? validateEmail(String? val) {
  if (val == null || val.isEmpty) return 'Please enter email';
  GetUtils.isEmail(val) ? null : 'Please enter valid email';
  return null;
}

String? validatePhone(String? val) {
  if (val == null || val.isEmpty) return 'Please enter phone number';
  return GetUtils.isPhoneNumber(val) ? null : 'Please enter valid phone number';
}

}