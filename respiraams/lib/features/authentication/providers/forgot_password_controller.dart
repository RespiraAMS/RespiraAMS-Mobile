import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/forgot_password_form_state.dart';

part 'forgot_password_controller.g.dart';

/// Holds the forgot-password form state and inline email validation.
@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  @override
  ForgotPasswordFormState build() => const ForgotPasswordFormState();

  void setEmail(String value) {
    // Clear the error as soon as the user edits again.
    state = state.copyWith(email: value, emailInvalid: false);
  }

  /// Validates the email; returns true when the code can be "sent".
  bool submit() {
    final email = state.email.trim();
    final valid = email.contains('@') && email.contains('.');
    state = valid
        ? state.copyWith(email: email, emailInvalid: false)
        : state.copyWith(email: email, emailInvalid: true);
    return valid;
  }
}
