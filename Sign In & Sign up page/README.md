# LUXE GROCERY — Flutter App (Phase 1: Login & Sign Up)

Premium grocery shopping app. Phase 1 contains only the **Login** (`/login`) and **Sign Up** (`/signup`) screens, the brand theme, and an authentication service ready to connect to Supabase later.

Checked with Flutter 3.41: `flutter analyze` → no issues, `flutter test` → all 8 tests pass.

## 1. Requirements
- Flutter SDK (latest stable) — https://docs.flutter.dev/get-started/install
- Android Studio (for the Android SDK + emulator)
- VS Code with the **Flutter** and **Dart** extensions

Check your setup: `flutter doctor`

## 2. Open in VS Code
1. Unzip `luxe_grocery.zip`.
2. VS Code → **File → Open Folder…** → choose the `luxe_grocery` folder.
3. Open a terminal (**Terminal → New Terminal**) and run:
   ```bash
   flutter pub get
   ```

## 3. Run on an Android emulator
1. Android Studio → **Device Manager** → create a device (e.g. Pixel 7) and start it.
   Or in VS Code: `Ctrl+Shift+P` → **Flutter: Launch Emulator**.
2. Pick the device in the VS Code status bar (bottom right).
3. Press **F5**, or run:
   ```bash
   flutter run
   ```

## 4. Check & test
```bash
flutter analyze
flutter test
```

## 5. Project structure
```
lib/
  main.dart                      # Entry point
  app/
    app.dart                     # MaterialApp
    app_colors.dart              # Official color palette (AppColors)
    app_theme.dart               # Material 3 theme, Poppins + Inter
    app_routes.dart              # /login, /signup
  core/
    constants/app_strings.dart   # All UI text (ready for Arabic later)
    constants/app_spacing.dart   # Spacing, radius, sizes
    validators/validators.dart   # Email / name / password rules
    utils/snackbar_utils.dart    # Friendly messages
    widgets/auth_scaffold.dart   # Ivory background + white card layout
  features/authentication/
    pages/login_page.dart
    pages/signup_page.dart
    services/auth_service.dart   # AuthService interface (backend not connected)
    widgets/
      brand_logo.dart            # Leaf + bag logo (CustomPainter)
      custom_text_field.dart
      primary_button.dart
      google_signin_button.dart
      auth_divider.dart
      auth_header.dart
      auth_footer_link.dart
      password_requirements.dart
assets/images/, assets/icons/    # Local assets (empty for now)
test/
  validators_test.dart
  widget_test.dart
android/ ios/ web/               # Platform folders
```

## 6. Authentication status
No backend is connected yet. `UnconfiguredAuthService` **never** pretends to log in: Sign In, Create Account, Google and Forgot Password all show
"Sign-in isn't available yet. Our account service still needs to be connected."

### Connecting Supabase later
1. Add `supabase_flutter` to `pubspec.yaml`.
2. Create `SupabaseAuthService implements AuthService` in `features/authentication/services/`.
3. Initialize Supabase in `main.dart`, then set
   `AuthServiceLocator.instance = SupabaseAuthService();`
The pages don't need to change. Google sign-in also needs OAuth credentials in Google Cloud + Supabase.

## 7. Next phases (not built yet)
Supabase Auth → profiles → existing Products table → categories → cart → checkout → orders.
