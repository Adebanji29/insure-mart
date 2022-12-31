class FormValidators {
  static String? validateEmail(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) return 'Please enter email';

    String pattern = r'\w+@\w+\.\w+';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(formEmail)) return 'Invalid Email Address';
    return null;
  }

  static String? validatePassword(String? formPassword) {
    if (formPassword == null || formPassword.isEmpty) {
      return 'Please enter password';
    }
    if (formPassword.length < 8) return 'Password length must be atleast 8';
    // String pattern =
    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#|$&*~]).{8,}$';
    // RegExp regex = RegExp(pattern);
    // if (!regex.hasMatch(formPassword)) {
    // return 'Password length must be atleast 8\ninclude an uppercase lowercase letter and symbol ';
    // }
    return null;
  }

  static String? validateCPassword(
      String? formPassword, String? formCPassword) {
    if (formPassword != formCPassword) {
      return 'Confirm Password must be same as password';
    }
    return null;
  }
}
