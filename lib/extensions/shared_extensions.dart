import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension BuildContextEntension<T> on BuildContext {
  bool get isX => MediaQuery.of(this).size.width >= 1440;
  bool get isL1 =>
      MediaQuery.of(this).size.width <= 1440 &&
      MediaQuery.of(this).size.width >= 1024;

  bool get isL2 =>
      MediaQuery.of(this).size.width <= 1024 &&
      MediaQuery.of(this).size.width >= 768;

  bool get isT =>
      MediaQuery.of(this).size.width <= 768 &&
      MediaQuery.of(this).size.width > 500;
  bool get isM => MediaQuery.of(this).size.width <= 500;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  // Size get size => MediaQuery.of(this).size;
}

extension FormValidators on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    final nameRegExp =
        RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    return nameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return isNotEmpty;
  }

  bool get isValidPhone {
    final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
    return phoneRegExp.hasMatch(this);
  }
}

extension FormTextInputFormatter on TextInputFormatter {
  static final _emailRegex = RegExp(r'^[0-9A-Za-z@.]+');
  static final _alphabetsRegex = RegExp(r'^[A-Za-z ]+');
  static final _numbersRegex = RegExp(r'^[0-9]+');

  static TextInputFormatter get email {
    return FilteringTextInputFormatter.allow(_emailRegex);
  }

  static TextInputFormatter get onlyAlphabets {
    return FilteringTextInputFormatter.allow(_alphabetsRegex);
  }

  static TextInputFormatter get onlyNumbers {
    return FilteringTextInputFormatter.allow(_numbersRegex);
  }

  static TextInputFormatter get double {
    return FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'));
  }
}
