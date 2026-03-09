class AppValidators {
  /// Empty validation
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "برجاء ادخال $fieldName";
    }
    return null;
  }

  /// Phone validation
  static String? phone(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return "برجاء ادخال $fieldName";
    }

    if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
      return "يجب أن يكون $fieldName مكون من 11 رقم";
    }

    return null;
  }

  /// National ID validation
  static String? nationalId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "برجاء ادخال الرقم القومي";
    }

    if (!RegExp(r'^[0-9]{14}$').hasMatch(value)) {
      return "الرقم القومي يجب أن يكون 14 رقم";
    }

    return null;
  }

  /// Password validation
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return "برجاء ادخال كلمة المرور";
    }

    if (value.length < 8) {
      return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
    }

    if (!RegExp(r'[A-Za-z]').hasMatch(value)) {
      return "يجب أن تحتوي كلمة المرور على حروف";
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return "يجب أن تحتوي كلمة المرور على رقم";
    }

    return null;
  }

  /// Confirm password validation
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "برجاء تأكيد كلمة المرور";
    }

    if (value != password) {
      return "كلمة المرور غير متطابقة";
    }

    return null;
  }
}
