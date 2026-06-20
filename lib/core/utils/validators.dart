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
}
