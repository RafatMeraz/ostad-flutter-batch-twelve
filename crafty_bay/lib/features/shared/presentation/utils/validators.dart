class Validators {
  static String? validateText(String? value, String message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? validateEmail(String? value, String message) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if ((value == null || value.isEmpty) || !emailRegExp.hasMatch(value)) {
      return message;
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password should at least 6 letters';
    }
    return null;
  }
}
