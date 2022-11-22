class Validator {
  static String? getBlankFieldValidator(String? name) {
    if (name == null || name.isEmpty) {
      return "This Field is Required";
    }
    return null;
  }

  static String? getPasswordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return "Password Shall be Provided";
    }
    return null;
  }

  static String? getEmailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return "Email Shall be Provided";
    }
    if (!email.contains("@") || !email.contains(".com")) {
      return "Email Address is Not Valid";
    }
    return null;
  }

  static String? getPhoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "Phone Shall be Provided";
    }
    if (phone.length != 10) {
      return "Phone Number is Not Valid";
    }
    return null;
  }

  static String? getNumberValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return "This field shall be Provided";
    }

    return null;
  }
}
