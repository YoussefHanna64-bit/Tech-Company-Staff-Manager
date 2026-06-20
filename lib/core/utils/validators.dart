class Validators {
  static String? validateEmail(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      return "Email is required";
    }

    final hasAtSymbol = text.contains("@");
    final hasDot = text.contains(".");

    if (!hasAtSymbol || !hasDot) {
      return "Enter a valid email address";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      return "Password is required";
    }

    if (text.length < 8) {
      return "Password must be at least 8 characters";
    }

    return null;
  }

  static String? validateMinLength(
    String? value,
    int minLength,
    String fieldName,
  ) {
    final text = value?.trim() ?? "";

    if (text.isEmpty) {
      return "$fieldName is required";
    }

    if (text.length < minLength) {
      return "$fieldName must be at least $minLength characters";
    }

    return null;
  }

  static String? validateSalary(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Salary is required";
    }

    final salary = double.tryParse(value);
    if (salary == null) {
      return "Salary must be a number";
    }

    if (salary < 3000 || salary > 200000) {
      return "Salary must be between 3000 and 200000";
    }

    return null;
  }
}
