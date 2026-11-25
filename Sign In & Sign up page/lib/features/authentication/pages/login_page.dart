import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/app_colors.dart';
import '../../../app/app_routes.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/snackbar_utils.dart';
import '../../../core/validators/validators.dart';
import '../../../core/widgets/auth_scaffold.dart';
import '../services/auth_service.dart';
import '../widgets/auth_divider.dart';
import '../widgets/auth_footer_link.dart';
import '../widgets/auth_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/google_signin_button.dart';
import '../widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _passwordFocus = FocusNode();
  final AuthService _auth = AuthServiceLocator.instance;

  bool _loading = false;
  bool _googleLoading = false;

  bool get _isValid =>
      Validators.email(_email.text) == null &&
      Validators.requiredPassword(_password.text) == null;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    final result = await _auth.signInWithEmail(
        email: _email.text.trim(), password: _password.text);
    if (!mounted) return;
    setState(() => _loading = false);
    if (!result.success) {
      showAppMessage(context, result.message ?? AppStrings.backendNotConfigured);
    }
    // On success (once a backend is connected) navigate to the home page here.
  }

  Future<void> _google() async {
    setState(() => _googleLoading = true);
    final result = await _auth.signInWithGoogle();
    if (!mounted) return;
    setState(() => _googleLoading = false);
    if (!result.success) {
      showAppMessage(context, result.message ?? AppStrings.backendNotConfigured);
    }
  }

  Future<void> _forgotPassword() async {
    final emailError = Validators.email(_email.text);
    if (emailError != null) {
      showAppMessage(context, 'Enter your email address above first.');
      return;
    }
    final result = await _auth.sendPasswordReset(_email.text.trim());
    if (!mounted) return;
    showAppMessage(context,
        result.success ? 'Check your inbox for a reset link.' : result.message!);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Form(
        key: _formKey,
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthHeader(
                  title: AppStrings.loginTitle, subtitle: AppStrings.loginSubtitle),
              const SizedBox(height: 28),
              CustomTextField(
                label: AppStrings.email,
                hint: AppStrings.emailHint,
                icon: Icons.mail_outline,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: Validators.email,
                onChanged: (_) => setState(() {}),
                onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: AppStrings.password,
                hint: AppStrings.passwordHint,
                icon: Icons.lock_outline,
                controller: _password,
                focusNode: _passwordFocus,
                isPassword: true,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.password],
                validator: Validators.requiredPassword,
                onChanged: (_) => setState(() {}),
                onFieldSubmitted: (_) => _isValid ? _submit() : null,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _forgotPassword,
                  style: TextButton.styleFrom(foregroundColor: AppColors.forestGreen),
                  child: Text(AppStrings.forgotPassword,
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                label: AppStrings.signIn,
                isLoading: _loading,
                onPressed: _isValid ? _submit : null,
              ),
              const SizedBox(height: 20),
              const AuthDivider(text: AppStrings.or),
              const SizedBox(height: 20),
              GoogleSignInButton(
                label: AppStrings.continueWithGoogle,
                isLoading: _googleLoading,
                onPressed: _google,
              ),
              const SizedBox(height: 16),
              AuthFooterLink(
                prompt: AppStrings.noAccount,
                action: AppStrings.createAccount,
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.signup),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
