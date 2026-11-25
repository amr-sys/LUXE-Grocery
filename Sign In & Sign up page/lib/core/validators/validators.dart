/// Pure validation functions. Return null when valid, or a friendly message.
class Validators {
  Validators._();

  static final RegExp _email = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]{2,}$');

  static String? fullName(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Please enter your full name.';
    if (s.length < 2) return 'Your name looks a little short.';
    return null;
  }

  static String? email(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return 'Please enter your email address.';
    if (!_email.hasMatch(s)) return 'Please enter a valid email address.';
    return null;
  }

  static String? requiredPassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter your password.';
    return null;
  }

  static bool hasMinLength(String v) => v.length >= 8;
  static bool hasUppercase(String v) => v.contains(RegExp(r'[A-Z]'));
  static bool hasLowercase(String v) => v.contains(RegExp(r'[a-z]'));
  static bool hasNumber(String v) => v.contains(RegExp(r'[0-9]'));

  static String? strongPassword(String? v) {
    final s = v ?? '';
    if (s.isEmpty) return 'Please create a password.';
    if (!hasMinLength(s) || !hasUppercase(s) || !hasLowercase(s) || !hasNumber(s)) {
      return 'Your password doesn\'t meet all requirements yet.';
    }
    return null;
  }

  static String? confirmPassword(String? v, String original) {
    if (v == null || v.isEmpty) return 'Please confirm your password.';
    if (v != original) return 'Passwords don\'t match.';
    return null;
  }
}
