import 'package:flutter/material.dart';

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
import '../widgets/password_requirements.dart';
import '../widgets/primary_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();
  final AuthService _auth = AuthServiceLocator.instance;

  bool _loading = false;
  bool _googleLoading = false;

  bool get _isValid =>
      Validators.fullName(_name.text) == null &&
      Validators.email(_email.text) == null &&
      Validators.strongPassword(_password.text) == null &&
      Validators.confirmPassword(_confirm.text, _password.text) == null;

  @override
  void dispose() {
    for (final c in [_name, _email, _password, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  void _refresh(String _) => setState(() {});

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    final result = await _auth.signUpWithEmail(
        fullName: _name.text.trim(), email: _email.text.trim(), password: _password.text);
    if (!mounted) return;
    setState(() => _loading = false);
    if (!result.success) {
      showAppMessage(context, result.message ?? AppStrings.backendNotConfigured);
    }
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

  void _goToLogin() {
    final nav = Navigator.of(context);
    if (nav.canPop()) {
      nav.pop();
    } else {
      nav.pushReplacementNamed(AppRoutes.login);
    }
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
                  title: AppStrings.signupTitle, subtitle: AppStrings.signupSubtitle),
              const SizedBox(height: 28),
              CustomTextField(
                label: AppStrings.fullName,
                hint: AppStrings.fullNameHint,
                icon: Icons.person_outline,
                controller: _name,
                textCapitalization: TextCapitalization.words,
                autofillHints: const [AutofillHints.name],
                validator: Validators.fullName,
                onChanged: _refresh,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: AppStrings.email,
                hint: AppStrings.emailHint,
                icon: Icons.mail_outline,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: Validators.email,
                onChanged: _refresh,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: AppStrings.password,
                hint: AppStrings.createPasswordHint,
                icon: Icons.lock_outline,
                controller: _password,
                isPassword: true,
                autofillHints: const [AutofillHints.newPassword],
                validator: Validators.strongPassword,
                onChanged: _refresh,
              ),
              const SizedBox(height: 10),
              PasswordRequirements(password: _password.text),
              const SizedBox(height: 16),
              CustomTextField(
                label: AppStrings.confirmPassword,
                hint: AppStrings.confirmPasswordHint,
                icon: Icons.lock_outline,
                controller: _confirm,
                isPassword: true,
                textInputAction: TextInputAction.done,
                validator: (v) => Validators.confirmPassword(v, _password.text),
                onChanged: _refresh,
                onFieldSubmitted: (_) => _isValid ? _submit() : null,
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: AppStrings.createAccount,
                isLoading: _loading,
                onPressed: _isValid ? _submit : null,
              ),
              const SizedBox(height: 20),
              const AuthDivider(text: AppStrings.or),
              const SizedBox(height: 20),
              GoogleSignInButton(
                label: AppStrings.signUpWithGoogle,
                isLoading: _googleLoading,
                onPressed: _google,
              ),
              const SizedBox(height: 16),
              AuthFooterLink(
                prompt: AppStrings.haveAccount,
                action: AppStrings.signIn,
                onTap: _goToLogin,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
