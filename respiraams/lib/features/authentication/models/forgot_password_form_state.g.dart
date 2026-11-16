// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_form_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForgotPasswordFormStateImpl _$$ForgotPasswordFormStateImplFromJson(
  Map<String, dynamic> json,
) => _$ForgotPasswordFormStateImpl(
  email: json['email'] as String? ?? '',
  emailInvalid: json['emailInvalid'] as bool? ?? false,
);

Map<String, dynamic> _$$ForgotPasswordFormStateImplToJson(
  _$ForgotPasswordFormStateImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'emailInvalid': instance.emailInvalid,
};
