import 'package:bot_toast/bot_toast.dart';
import 'package:construction/utils/app_colors.dart';

class Validator {
  static getBlankFieldValidator(String? name, String value) {
    if (name == null || name.isEmpty) {
      return BotToast.showText(
          text: "$value is required", contentColor: AppColors.red);
    }
    return null;
  }

  static getPasswordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return BotToast.showText(
          text: "Password Shall be Provided", contentColor: AppColors.red);
    }
    return null;
  }

  static getEmailValidator(String? email) {
    if (email == null || email.isEmpty) {
      return BotToast.showText(
          text: "Email Shall be Provided", contentColor: AppColors.red);
    }
    if (!email.contains("@") || !email.contains(".com")) {
      return BotToast.showText(
          text: "Email Address is Not Valid", contentColor: AppColors.red);
    }
    return null;
  }

  static getPhoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) {
      return BotToast.showText(
          text: "Phone Shall be Provided", contentColor: AppColors.red);
    }
    if (phone.length != 10) {
      return BotToast.showText(
          text: "Phone Number is Not Valid", contentColor: AppColors.red);
    }
    return null;
  }

  static getNumberValidator(String? number, String value) {
    if (number == null || number.isEmpty) {
      return BotToast.showText(
          text: "$value shall be Provided", contentColor: AppColors.red);
    }

    return null;
  }
}
