/// Result of an authentication attempt.
class AuthResult {
  const AuthResult._(this.success, this.message);
  const AuthResult.success() : this._(true, null);
  const AuthResult.failure(String message) : this._(false, message);

  final bool success;
  final String? message;
}

/// Contract the UI depends on. Implement it later with Supabase Auth
/// (e.g. `SupabaseAuthService`) without touching the pages.
abstract class AuthService {
  bool get isConfigured;
  Future<AuthResult> signInWithEmail({required String email, required String password});
  Future<AuthResult> signUpWithEmail(
      {required String fullName, required String email, required String password});
  Future<AuthResult> signInWithGoogle();
  Future<AuthResult> sendPasswordReset(String email);
}

/// Default implementation used until the backend is connected.
/// It never pretends to succeed: every call returns a friendly
/// "not configured" failure.
class UnconfiguredAuthService implements AuthService {
  const UnconfiguredAuthService();

  static const _msg =
      'Sign-in isn\'t available yet. Our account service still needs to be connected.';

  @override
  bool get isConfigured => false;

  Future<AuthResult> _notConfigured() async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return const AuthResult.failure(_msg);
  }

  @override
  Future<AuthResult> signInWithEmail({required String email, required String password}) =>
      _notConfigured();

  @override
  Future<AuthResult> signUpWithEmail(
          {required String fullName, required String email, required String password}) =>
      _notConfigured();

  @override
  Future<AuthResult> signInWithGoogle() => _notConfigured();

  @override
  Future<AuthResult> sendPasswordReset(String email) => _notConfigured();
}

/// Single place to swap the implementation later.
class AuthServiceLocator {
  AuthServiceLocator._();
  static AuthService instance = const UnconfiguredAuthService();
}
