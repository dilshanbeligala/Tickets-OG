
class Validator {
  static String regexEmail = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String regexPhone = r'^[1-9][0-9]{8}$';
  static String regexOldNic = r'^\d{9}[VXvx]$';
  static String regexNewNic = r'^\d{12}$';
  static String regexPassport = r'^[a-zA-Z0-9]{6,9}$';

  static String? validateEmail(String? value) {
    RegExp regExp = RegExp(regexEmail);
    if (value == null || value.isEmpty) {
      return 'Please enter your Email Address';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid Email Address';
    }
    return null;
  }

  static String? validatePassword(String? password, {String? label}) {
    if (password == null || password.isEmpty) {
      return '${label ?? 'Password'} cannot be empty';
    }
    if (password.length < 6) {
      return '${label ?? 'Password'} must be at least 6 characters long';
    }
    return null;
  }

}